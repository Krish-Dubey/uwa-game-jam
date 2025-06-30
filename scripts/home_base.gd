extends Area2D

var health = 20
var maxhealth = 20
@export var health_bar : ProgressBar

@export var game_over_screen : PackedScene

func _on_area_entered(area: Area2D) -> void:
	health -= area.get_parent().base_damage
	health_bar.value = (health / maxhealth) * 100
	if health == 0:
		var game_over = game_over_screen.instantiate()
		get_tree().current_scene.add_child(game_over)
	area.get_parent().queue_free()

func _ready() -> void:
	health_bar.value = 100
