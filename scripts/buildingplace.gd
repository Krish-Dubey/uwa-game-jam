extends Node2D

@export var tile_map : TileMapLayer
@export var road_tile_map : TileMapLayer

var highlight_blue_scene = preload("res://scenes/highlight_blue.tscn")
var highlight_blue
var highlight_red_scene = preload("res://scenes/highlight_red.tscn")
var highlight_red
var building_id : int
var build_mode : bool = false

func _ready() -> void:
	highlight_blue =  highlight_blue_scene.instantiate()
	add_child(highlight_blue)
	highlight_blue.visible = false
	highlight_red =  highlight_red_scene.instantiate()
	add_child(highlight_red)
	highlight_red.visible = false


func _process(delta: float) -> void:
	if build_mode:
		
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		var tile_data = road_tile_map.get_cell_tile_data(road_tile_map.local_to_map(mouse_pos))
		var highlight_pos = tile_map.map_to_local(tile_mouse_pos)
		if tile_data == null or tile_map.get_cell_atlas_coords(tile_mouse_pos) == Vector2i(0,0):
			highlight_red.visible = true
			highlight_blue.visible = false
			highlight_red.global_position = highlight_pos
		else:
			highlight_red.visible = false
			highlight_blue.visible = true
			highlight_blue.global_position = highlight_pos
		
		
		
	elif !build_mode:
		highlight_blue.visible = false
		highlight_red.visible = false
		pass

func _input(event):
	if build_mode:
		
		
		if Input.is_action_just_pressed("left_click"):
			place_building(building_id)
		elif Input.is_action_just_pressed("right_click"):
			build_mode = false
		pass
		
func place_building(id):
	var mouse_pos = get_global_mouse_position()
	var tile_mouse_pos = tile_map.local_to_map(mouse_pos)
	var tile_data = road_tile_map.get_cell_tile_data(road_tile_map.local_to_map(mouse_pos))
	if tile_data == null or tile_map.get_cell_atlas_coords(tile_mouse_pos) == Vector2i(0,0):
		print("You cant place on a road")
	else:
		tile_map.set_cell(tile_mouse_pos, 0, Vector2i(0,0), id)
