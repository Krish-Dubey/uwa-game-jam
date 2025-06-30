extends CharacterBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var road_tile
@onready var path
@onready var path_id = 1
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var last_path_size
@onready var hurt_box: Area2D = $Area2D2


var path_changed = false
var attacking = false
var navigation_target = Vector2.ZERO #Initial Target

var target = null

@export var damage_timer: Timer
@export var movement_speed: float = 50
@export var damage: int = 25

func _ready() -> void:
	anim_sprite.speed_scale = movement_speed /2


func _physics_process(delta: float) -> void:
	last_path_size = path.size()
	if last_path_size != path.size():
		path_changed = true
	
	var current_position
	var target_position
	var dist
	var min_distance = INF
	if path_changed:
		for id in path.size():
			dist = global_position.distance_to(road_tile.map_to_local(path[id]))
			if dist < min_distance:
				min_distance = dist
				path_id = id
		path_changed = false
	if path_id < path.size():
		target_position = road_tile.map_to_local(path[path_id])
		min_distance = global_position.distance_to(target_position) 
		if min_distance < 10:
			path_id += 1
	print(path.size())
	if path.size() > 0:
		var new_velocity = global_position.direction_to(target_position) * movement_speed
		velocity = new_velocity
		attacking = false
	else:
		var new_velocity = global_position.direction_to(navigation_target) * movement_speed
		velocity = new_velocity
		attacking = true
	move_and_slide()


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if attacking:
		area.get_parent().health_component.take_damage(damage)
		target = area.get_parent().health_component
		damage_timer.start(1)


func _on_area_2d_2_area_exited(area: Area2D) -> void:
	damage_timer.stop()
	target = null
	attacking = false

func _on_timer_timeout() -> void:
	if target:
		target.take_damage(damage)
