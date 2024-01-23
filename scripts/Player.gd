extends Area2D

const SPEED := 500
const FADE_SPEED := 8
const FOCUS_SLOWDOWN := 0.4
const SHOT_COOLDOWN := 5

const MARGIN := 10

const PlayerShot = preload("res://scenes/PlayerShot.tscn")

var shot_cooldown := 0

func _ready():
	area_entered.connect(Callable(self, "_on_area_entered"))

func _physics_process(delta):
	movement(delta)
	focus(delta)
	shoot()

#region # stuff that runs every frame
func movement(delta):
	var direction := Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	if Input.is_action_pressed("focus"):
		direction *= FOCUS_SLOWDOWN
	position += direction * delta * SPEED
	position.x = clamp(position.x, 48 + MARGIN, 48 + 576 - MARGIN)
	position.y = clamp(position.y, 24 + MARGIN, 24 + 672 - MARGIN)
	
func focus(delta):
	if Input.is_action_pressed("focus"):
		$Indicators.modulate.a = clamp($Indicators.modulate.a + FADE_SPEED * delta, 0, 1)
	else:
		$Indicators.modulate.a = clamp($Indicators.modulate.a - FADE_SPEED * delta, 0, 1)

func shoot():
	if Input.is_action_pressed("shoot") && shot_cooldown == 0:
		shot_cooldown = SHOT_COOLDOWN
		var shot_count = floor(Global.power) + 1
		for i in shot_count:
			var new_shot = PlayerShot.instantiate()
			new_shot.position = self.position + Vector2(10 * (i-(shot_count-1)/2), 0)
			$"..".add_child(new_shot)
	shot_cooldown = max(shot_cooldown - 1, 0)
#endregion

func _on_area_entered(_area):
	hide()
	set_deferred("process_mode", PROCESS_MODE_DISABLED)
	print("skill issue")
