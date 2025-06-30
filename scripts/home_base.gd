extends Area2D

var health = 20

@export var game_over_screen : PackedScene

func _on_area_entered(area: Area2D) -> void:
	health -= area.get_parent().base_damage
	if health == 0:
		var game_over = game_over_screen.instantiate()
		get_tree().current_scene.add_child(game_over)
	area.get_parent().queue_free()
	
	
