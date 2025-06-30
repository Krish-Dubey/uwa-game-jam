extends Node

@export var max_health: float = 100
var health: float = 100

@export var agent: Node
@export var tile_map: TileMapLayer
@export var tile_position: Vector2i

func _ready() -> void:
	health = max_health

func take_damage(amount):
	print("OIOIOI")
	health -= amount
	if health <= 0:
		die()

func die():
	if tile_map:
		tile_map.set_cell(tile_position, -1)
		print("Cleared tile at", tile_position)
	agent.queue_free()
