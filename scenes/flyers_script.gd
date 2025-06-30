extends CharacterBody2D

@onready var health_component : HealthComponent = $HealthComponent
@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var road_tile
@onready var path
@onready var path_id = 1

@onready var last_path_size
@onready var hurt_box: Area2D = $Area2D2



var navigation_target = Vector2.ZERO #Initial Target

@export var movement_speed: float = 50


func _ready() -> void:
	anim_sprite.speed_scale = movement_speed /2


func _physics_process(delta: float) -> void:
	
	
	
	var new_velocity = global_position.direction_to(navigation_target) * movement_speed
	velocity = new_velocity

	move_and_slide()
