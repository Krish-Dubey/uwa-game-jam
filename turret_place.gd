extends Node2D

@export var tile_map : TileMapLayer
@export var road_tile_map : TileMapLayer

func _input(event):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		
		var road_tile_map = road_tile_map.get_cell_source_id(road_tile_map.local_to_map(mouse_pos))
		
		if road_tile_map == 1:
			print("You cant place on a road")
		else:
			print(tile_mouse_pos)
			tile_map.set_cell(tile_mouse_pos, 2, Vector2i(0,0), 1)
		
