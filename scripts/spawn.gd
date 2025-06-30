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

var categories_string = ["common", "uncommon", "rare", "boss"]
var rng = RandomNumberGenerator.new()

signal new_wave

var currentWave = 0
var currentBasePoints = 5
var enemy_wave = []

var common_cutoff = 0
var uncommon_cutoff = 95
var rare_cutoff = 105
var boss_cutoff = 110

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
	EnemyInfo.loadAllEnemies()

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
	var currentPoint = currentBasePoints + currentWave + PlayerEconomy.PollutionLevel
	uncommon_cutoff -= (PlayerEconomy.PollutionLevel - 1)
	rare_cutoff -= (PlayerEconomy.PollutionLevel - 1)
	
	if currentWave == 10:
		boss_cutoff -= 10
	elif currentWave % 10 == 0:
		boss_cutoff -= 5
	
	wave_label.text = "Waves : " + str(currentWave)
	
	while currentPoint > 0:
		var random_number = rng.randi_range(0, 100)
		var target_category = -1
		var can_spawn = 0
		var category_to_spawn
		
		if random_number > boss_cutoff:
			target_category = 3
		elif random_number > rare_cutoff:
			target_category = 2
		elif random_number > uncommon_cutoff:
			target_category = 1
		else:
			target_category = 0 
		
		while can_spawn == 0:
			for enemy in EnemyInfo.getCategory(categories_string[target_category]):
				if enemy[1] <= currentPoint:
					can_spawn = 1 
					category_to_spawn = EnemyInfo.getCategory(categories_string[target_category])
					break
			target_category -= 1 # Can't find anything to spawn going down a level. Common is guaranteed to spawn something!
		
		var random_enemy = rng.randi_range(0, category_to_spawn.size() - 1)
		
		enemy_wave.append(EnemyInfo.LoadedEnemies[category_to_spawn[random_enemy][0]])
		currentPoint -= category_to_spawn[random_enemy][1]
	
	new_wave.emit()
	next_wave_button.disabled = true
	for buttons in buldings_button:
		buttons.disabled = true
	placement_script.build_mode = false
	EnemyContainer.wave_standby = 0

func _on_enemy_container_wave_end() -> void:
	next_wave_button.disabled = false
	for buttons in buldings_button:
		buttons.disabled = false
	pass

func _on_path_update_timer_timeout() -> void:
	#print(id_path)
	update_astar_path()
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.path = id_path
	pass # Replace with function body.
