extends Area2D

var health = 20

func _on_body_entered(body) -> void:
	health -= 1
	if health == 0:
		print("dead")
	body.queue_free()
