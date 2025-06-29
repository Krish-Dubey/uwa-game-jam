extends Node2D

@export var turret_range: float = 200
@export var fire_rate: float = 1

@export var bullet_scene : PackedScene
@export var projectile_spawn_position: Node2D

var shot: bool = false

var time_since_last_shot := 0.0

func _physics_process(delta: float) -> void:
	time_since_last_shot += delta
	var closest_enemy = get_closest_enemy_in_range(turret_range)
	
	if closest_enemy != null:
		var dist = global_position.distance_to(closest_enemy.global_position)
		if turret_range > dist:
			
			look_at(closest_enemy.global_position)
			if time_since_last_shot >= fire_rate:
				shot = true
				shoot()
				time_since_last_shot = 0.0
	
	

func get_closest_enemy_in_range(range: float) -> Node2D:
	var closest_enemy
	var closest_distance = range  # Only check within this distance
	var my_position = global_position
	for enemy in get_tree().get_nodes_in_group("enemy"):
		if not is_instance_valid(enemy):
			continue

		var dist = my_position.distance_to(enemy.global_position)
		if dist <= closest_distance:
			closest_distance = dist
			closest_enemy = enemy

	return closest_enemy


func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = projectile_spawn_position.global_position
	bullet.global_rotation = global_rotation
	get_tree().current_scene.add_child(bullet)
	shot = false
