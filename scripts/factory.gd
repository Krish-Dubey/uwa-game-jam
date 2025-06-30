extends Node2D

@export var pollution: float = 50
@onready var SpawnNode = $"../../../Spawn"
var EnemyContainer : Node

func _ready():
	print(SpawnNode.get_children()[2])
	print(SpawnNode.enemy_wave)
