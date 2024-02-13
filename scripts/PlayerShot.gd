extends Area2D

const SPEED = 1200

func _ready():
	area_entered.connect(Callable(self, "_on_area_entered"))

func _physics_process(delta):
	position.y -= SPEED * delta
	if position.y < -20:
		queue_free()

func _on_area_entered(_area):
	if Global.is_enemy_vulnerable:
		Global.enemy_health -= 1
		print(Global.enemy_health)
	queue_free()
