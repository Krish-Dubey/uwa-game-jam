extends Node2D

@export var tile_map : TileMapLayer

func _input(event):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		print(tile_mouse_pos)
		tile_map.set_cell(tile_mouse_pos, 2, Vector2i(0,0), 1)
		
