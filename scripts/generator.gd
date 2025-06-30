extends Node2D

@export var pollution: float = -25
@export var energy_generated: float = 0
@onready var SpawnNode = $"../../../Spawn"
@onready var PlayerEconomy = $"../../../PlayerNode/PlayerEconomy"
var EnemyContainer : Node
@onready var NextWaveButton = SpawnNode.next_wave_button
@onready var health_component = $HealthComponent
