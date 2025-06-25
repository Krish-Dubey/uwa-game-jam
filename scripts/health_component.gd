extends Node
class_name HealthComponent

@export var max_health: float = 100
var health: float = 100

@export var agent: Node #The entity to be destroyed when health reaches zero, assign it in the Inspector.

func _ready() -> void:
	health = max_health

func take_damage(amount):
	health -= amount
	print(health)
	if health <= 0:
		die()

func die():
	agent.queue_free()
