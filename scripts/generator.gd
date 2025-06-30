extends Node2D

@export var pollution: float = 50
@export var energy_generated: float = 10
@onready var SpawnNode = $"../../../Spawn"
@onready var PlayerEconomy = $"../../../PlayerNode/PlayerEconomy"
var EnemyContainer : Node
@onready var NextWaveButton = SpawnNode.next_wave_button
