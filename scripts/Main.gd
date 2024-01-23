extends Control

@onready var Controller:BattleController = $Arena/BattleController
@onready var GrazeAudio = $Audio/Graze
@onready var SpawnAudio = $Audio/Spawn


func _ready():
	STGGlobal.bullet_spawned.connect(Callable(self, "_on_bullet_spawned"))
	STGGlobal.graze.connect(Callable(self, "_on_graze"))
	STGGlobal.spell_changed.connect(Callable(self, "_on_spell_changed"))
	Controller.start()

# called every time a bullet is spawned.
func _on_bullet_spawned(_bullet):
	SpawnAudio.play()

# called every time a bullet is grazed.
func _on_graze(bullet):
	bullet.custom_data *= 0.75
	GrazeAudio.play()

func _on_spell_changed(_data, life):
	Global.max_health = life
	Global.enemy_health = life
