extends Area2D

var health = 20

func _on_area_entered(area: Area2D) -> void:
	health -= area.get_parent().base_damage
	if health == 0:
		print("dead")
	area.get_parent().queue_free()
	
	
