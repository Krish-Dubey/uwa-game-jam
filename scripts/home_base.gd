extends Area2D

var health = 20
var maxhealth = 20
@export var health_bar : ProgressBar

func _on_area_entered(area: Area2D) -> void:
	health -= area.get_parent().base_damage
	health_bar.value = (health / maxhealth) * 100
	if health == 0:
		print("dead")
	area.get_parent().queue_free()

func _ready() -> void:
	health_bar.value = 100
