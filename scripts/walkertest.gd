extends CharacterBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var road_tile
@onready var path
@onready var path_id = 1

var navigation_target = Vector2.ZERO #Initial Target
@export var movement_speed: float = 50

func _physics_process(delta: float) -> void:
	var current_position
	var target_position
	var dist
	var min_distance = INF
	for id in path.size():
		dist = global_position.distance_to(road_tile.map_to_local(path[id]))
		if dist < min_distance:
			min_distance = dist
			path_id = id
	target_position = road_tile.map_to_local(path[path_id])
	min_distance = global_position.distance_to(target_position) 
	if min_distance < 10:
		path_id += 1
		path.pop_front()
	#print(global_position, " and ", target_position)
	
	var new_velocity = global_position.direction_to(target_position) * movement_speed
	velocity = new_velocity
	
	#navigation_agent_2d.target_position = navigation_target
	#var current_agent_position = global_position
	#var next_path_position = navigation_agent_2d.get_next_path_position()
	#var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	#velocity = new_velocity
	move_and_slide()
