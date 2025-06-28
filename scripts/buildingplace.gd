extends Node2D

@export var tile_map : TileMapLayer
@export var road_tile_map : TileMapLayer
var building_coordinate: Dictionary[Vector2i, Node] = {}



func _input(event):
	if Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		
		var tile_data = road_tile_map.get_cell_tile_data(road_tile_map.local_to_map(mouse_pos))
		print(tile_map.get_cell_atlas_coords(tile_mouse_pos))
		print(tile_data)
		if tile_data == null or tile_map.get_cell_atlas_coords(tile_mouse_pos) == Vector2i(0,0):
			print("You cant place on a road")
		else:

			tile_map.set_cell(tile_mouse_pos, 0, Vector2i(0,0), 1)
	
	if Input.is_action_just_pressed("right_click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		
		var tile_data = road_tile_map.get_cell_tile_data(road_tile_map.local_to_map(mouse_pos))
		
		if tile_data == null or tile_map.get_cell_atlas_coords(tile_mouse_pos) == Vector2i(0,0):
			print("You cant place on a road")
		else:
			tile_map.set_cell(tile_mouse_pos, 0, Vector2i(0,0), 2)
		
func generate3grid(position: Vector2i):
	var created_map: Array[Vector2i] = []

	for y in range(3):
		for x in range(3):
			var cell_pos = position * 3 + Vector2i(x, y)
			created_map.append(cell_pos)

	print("Created Map Pos:", created_map)

	road_tile_map.set_cells_terrain_connect(created_map, 0, 0, 1)
