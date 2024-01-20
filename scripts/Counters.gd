extends Panel

@onready var Lives = $VBoxContainer/Lives/Value
@onready var Bombs = $VBoxContainer/Bombs/Value
@onready var Graze = $VBoxContainer/Graze/Value

var graze_count:int = 0

func _ready():
	STGGlobal.bullet_spawned.connect(Callable(self, "_on_bullet_spawned"))
	STGGlobal.graze.connect(Callable(self, "_on_graze"))
	Graze.text = "0"

# called every time a bullet is grazed.
func _on_graze(_bullet):
	graze_count += 1
	Graze.text = str(graze_count)

func _on_bullet_spawned(bullet):
	print(bullet)
