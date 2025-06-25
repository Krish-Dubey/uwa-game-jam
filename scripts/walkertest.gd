extends CharacterBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var navigation_target = Vector2.ZERO #Initial Target
@export var movement_speed: float = 50


func _physics_process(delta: float) -> void:
	navigation_agent_2d.target_position = navigation_target
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	velocity = new_velocity
	move_and_slide()
	
	pass	
