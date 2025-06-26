extends Marker2D

@export var target : Node2D
@onready var EnemyInfo = $EnemyInfo

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	 
func spawn_enemy() -> void:
	var enemy = EnemyInfo.getAllEnemyInfo()[0]["LoadedRes"].instantiate()
	
	add_child(enemy)
 
	enemy.global_transform.origin = global_position
	enemy.navigation_target = target.global_transform.origin
