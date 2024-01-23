extends Node

@onready var LivesCounter = $/root/Main/UI/Counters/VBoxContainer/Lives/Value
@onready var BombsCounter = $/root/Main/UI/Counters/VBoxContainer/Bombs/Value
@onready var PowerCounter = $/root/Main/UI/Counters/VBoxContainer/Power/Value
@onready var GrazeCounter = $/root/Main/UI/Counters/VBoxContainer/Graze/Value
@onready var EnemyHealthBar = $/root/Main/Arena/Enemy/HealthBar

var max_health := 0

var enemy_health := 0:
	set(val):
		enemy_health = val
		EnemyHealthBar.value = float(val)/max_health
		STGGlobal.update_health(val)
		#STGGlobal.damage_taken.emit(val) #directly calling the signal can crash the game.

var power := 0.0:
	set(val):
		power = val
		PowerCounter.text = str(val)
		
var graze := 0:
	set(val):
		graze = val
		GrazeCounter.text = str(val)

func _ready():
	STGGlobal.graze.connect(Callable(self, "_on_graze"))

func _on_graze(_bullet):
	graze += 1
