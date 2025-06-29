extends Button

@export var tile_id : int
@export var placement_script : Node2D

func _on_pressed() -> void:
	placement_script.build_mode = true
	placement_script.building_id = tile_id
	pass 
