extends Area2D

@export var speed := 400
@export var damage := 25
var direction := Vector2.RIGHT

func _physics_process(delta):
	position += direction.normalized() * speed * delta

func _on_area_entered(area) -> void:
	area.get_parent().health_component.take_damage(damage)
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
