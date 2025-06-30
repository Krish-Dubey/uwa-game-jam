extends Marker2D

@export var EnemyInfo = Node
@export var SpawnTimer = Node
@export var PlayerEconomy: Node 
@export var EnemyContainer: Node
@export var target : Node2D
@export var road_tile_map_ : TileMapLayer
@export var placement_tile: TileMapLayer
@export var wave_label : Label
@export var next_wave_button : Button
@export var buldings_button : Array[Button]
@export var placement_script : Node

var rng = RandomNumberGenerator.new()

signal new_wave

var currentWave = 0
var currentBasePoints = 10
var enemy_list = []
var common_enemy_list = []
var enemy_wave = []

var astar_grid: AStarGrid2D
var id_path

func _ready() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.region = road_tile_map_.get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.Heuristic.HEURISTIC_EUCLIDEAN
	astar_grid.update()
	update_astar_path()
	enemy_list = EnemyInfo.loadAllEnemies()

func update_astar_path():
	astar_grid.clear()  # clears all points and solid data

	astar_grid.region = road_tile_map_.get_used_rect()
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.update()  # repopulate the grid

	var start = road_tile_map_.local_to_map(global_position)
	var end = road_tile_map_.local_to_map(target.global_position)

	# Now mark unwalkable tiles again
	var used_rect = road_tile_map_.get_used_rect()
	for x in range(used_rect.size.x):
		for y in range(used_rect.size.y):
			var tile_position = Vector2i(
				x + used_rect.position.x,
				y + used_rect.position.y
			)
			var tile_data = road_tile_map_.get_cell_tile_data(tile_position)
			if tile_data == null or tile_data.get_custom_data("unwalkable"):
				if tile_position != start and tile_position != end:
					astar_grid.set_point_solid(tile_position)

	# Re-mark placement tiles (towers)
	for tile in placement_tile.get_used_cells():
		if tile != start and tile != end:
			astar_grid.set_point_solid(tile)

	# Compute path again
	id_path = astar_grid.get_id_path(start, end).slice(1)
	
func spawn_enemy(enemy_packed_scene) -> void:
	update_astar_path()
	var spawned_enemy = enemy_packed_scene.instantiate()
	EnemyContainer.add_child(spawned_enemy)
	spawned_enemy.path = id_path
	spawned_enemy.global_transform.origin = global_position
	spawned_enemy.navigation_target = target.global_transform.origin
	spawned_enemy.road_tile = road_tile_map_
	
func _on_spawn_timer_timeout() -> void:
	if enemy_wave != []:
		spawn_enemy(enemy_wave[-1])
		enemy_wave.remove_at(enemy_wave.size()-1)
	else:
		SpawnTimer.stop()
	
func create_wave():
	update_astar_path()
	SpawnTimer.start()
	currentWave += 1
	var currentPoint = currentBasePoints + currentWave
	wave_label.text = "Waves : " + str(currentWave)
	var common_list = EnemyInfo.getCategory("common")
	while currentPoint > 0:
		enemy_wave.append(EnemyInfo.LoadedEnemies[rng.randi_range(0, EnemyInfo.LoadedEnemies.size() - 1)])
		currentPoint -= 1
	new_wave.emit()
	next_wave_button.disabled = true
	for buttons in buldings_button:
		buttons.disabled = true
	placement_script.build_mode = false
	EnemyContainer.wave_standby = 0

func _on_enemy_container_wave_end() -> void:
	#next_wave_button.disabled = false
	#for buttons in buldings_button:
		#buttons.disabled = false
	pass

func _on_path_update_timer_timeout() -> void:
	#print(id_path)
	update_astar_path()
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.path = id_path
	pass # Replace with function body.
