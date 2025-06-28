extends Marker2D

@export var target : Node2D
@onready var EnemyInfo = $EnemyInfo
@onready var SpawnTimer = $SpawnTimer
var currentWave = 0
var currentBasePoints = 3
var enemy_list = []
var common_enemy_list = []
var enemy_wave = []

func _on_spawn_timer_timeout() -> void:
	if enemy_wave != []:
		spawn_enemy(enemy_wave[-1])
		enemy_wave.remove_at(enemy_wave.size()-1)
	else:
		SpawnTimer.stop()

func spawn_enemy(enemy_packed_scene) -> void:
	var spawned_enemy = enemy_packed_scene.instantiate()
	add_child(spawned_enemy)
 
	spawned_enemy.global_transform.origin = global_position
	spawned_enemy.navigation_target = target.global_transform.origin

func create_wave():
	currentWave += 1
	var currentPoint = currentBasePoints + currentWave
	
	var common_list = EnemyInfo.getCategory("common")
	while currentPoint > 0:
		enemy_wave.append(EnemyInfo.LoadedEnemies[common_list[0]])
		currentPoint -= 1
		
func _ready() -> void:
	enemy_list = EnemyInfo.loadAllEnemies()
	create_wave()
	SpawnTimer.start()
