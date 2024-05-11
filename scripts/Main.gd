extends Control

@onready var Controller:BattleController = $Arena/BattleController
@onready var GrazeAudio = $Audio/Graze
@onready var SpawnAudio = $Audio/Spawn
@onready var Enemy = $Arena/Enemy

const PRE_SPELL_INVINCIBILITY := 1.5

func _ready():
	STGGlobal.bullet_spawned.connect(_on_bullet_spawned)
	STGGlobal.graze.connect(_on_graze)
	STGGlobal.spell_changed.connect(_on_spell_changed)
	STGGlobal.end_spell.connect(_on_end_spell)
	Controller.start()

# called every time a bullet is spawned.
func _on_bullet_spawned(_bullet):
	SpawnAudio.play()

# called every time a bullet is grazed.
func _on_graze(bullet):
	bullet.custom_data *= 0.75
	GrazeAudio.play()

func _on_spell_changed(data:STGCustomData):
	Global.max_health = data.health
	Global.enemy_health = data.health
	await get_tree().create_timer(PRE_SPELL_INVINCIBILITY, false).timeout
	Global.is_enemy_vulnerable = true

func _on_end_spell():
	Global.is_enemy_vulnerable = false
