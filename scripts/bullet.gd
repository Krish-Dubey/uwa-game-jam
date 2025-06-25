extends Area2D

@export var speed := 400
@export var damage := 25
var direction := Vector2.RIGHT

func _physics_process(delta):
	position += direction.normalized() * speed * delta



func _on_body_entered(body):
	if body.health_component.has_method("take_damage"):
		body.health_component.take_damage(damage)
	queue_free()
