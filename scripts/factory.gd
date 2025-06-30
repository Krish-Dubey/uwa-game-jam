extends Node2D

@export var pollution: float = 50
@onready var SpawnNode = $"../../../Spawn"
@onready var PlayerEconomy = $"../../../PlayerNode/PlayerEconomy"
var EnemyContainer : Node
@onready var NextWaveButton = SpawnNode.next_wave_button


func _ready():
	EnemyContainer = SpawnNode.get_children()[2]
	EnemyContainer.wave_end.connect(_on_wave_end)
	NextWaveButton.pressed.connect(_on_new_wave)

func _on_wave_end():
	pass	

func _on_new_wave():
	pass
