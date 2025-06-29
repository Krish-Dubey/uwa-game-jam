extends CharacterBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var road_tile
@onready var path
@onready var path_id = 1
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

var navigation_target = Vector2.ZERO #Initial Target
@export var movement_speed: float = 50


func _ready() -> void:
	anim_sprite.speed_scale = movement_speed /2


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
	

	move_and_slide()
