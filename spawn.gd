extends Marker2D

var enemy_scene = preload("res://scenes/walkertest.tscn")
@export var target : Node2D

func _on_spawn_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
 
	enemy.global_transform.origin = global_position
	enemy.navigation_target = target.global_transform.origin
