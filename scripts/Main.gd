extends Control

@onready var Controller:BattleController = $Arena/BattleController
@onready var GrazeAudio = $Audio/Graze

func _ready():
	STGGlobal.graze.connect(Callable(self, "_on_graze"))
	Controller.start()

# called every time a bullet is grazed.
func _on_graze(bullet):
	bullet.custom_data *= 0.75
	GrazeAudio.play()
