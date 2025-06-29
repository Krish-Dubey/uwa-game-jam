extends AnimatedSprite2D

@export var turret: Node2D

var play_anim = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if turret.time_since_last_shot == 0.0:
		play_anim = true
	if play_anim == true:
		play("default", turret.fire_rate * 3.5)
	#print(get_frame_progress())
	if get_frame_progress() > 0.9:
		play_anim = false
	
	
