extends Area2D

@export var speed := 400
@export var explosion_scene : PackedScene
@onready var sfx : AudioStreamPlayer = $AudioStreamPlayer

var direction := Vector2.RIGHT

func _ready() -> void:
	sfx.play(0.0)

func _physics_process(delta):
	position += direction.normalized() * speed * delta

func _on_area_entered(area) -> void:
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
