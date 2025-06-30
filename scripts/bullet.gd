extends Area2D

@export var speed := 400
@export var damage := 10
var direction := Vector2.RIGHT

@onready var sfx : AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	sfx.play(0.0)

func _physics_process(delta):
	position += direction.normalized() * speed * delta

func _on_area_entered(area) -> void:
	if area.get_parent().health_component != null:
		area.get_parent().health_component.take_damage(damage)

func _on_timer_timeout() -> void:
	queue_free()
