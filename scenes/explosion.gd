extends Node2D

@export var explosion_particle: GPUParticles2D
@export var damage = 20

func _ready() -> void:
	explosion_particle.emitting = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().health_component != null:
		area.get_parent().health_component.take_damage(damage)
	print("DOES IT REACH HERE")


func _on_gpu_particles_2d_finished() -> void:
	queue_free()
