extends Node

@export var EnergyBar : ProgressBar
@export var PollutionBar : ProgressBar

var ConstructionCash = 1500
var EnergyGenerated = 0
var CurrentPollution = 0

var PollutionLevel = 1
var EnergyQuotaLevel = 1

var buildings = []

@export var PollutionThreshold = 300
@export var QuotaThreshold = 100

func addPollution(pollution):
	CurrentPollution += pollution
	PollutionBar.value = (CurrentPollution / PollutionThreshold) * 100

func addEnergy(energy):
	EnergyGenerated += energy 
	EnergyBar.value = (EnergyGenerated / QuotaThreshold) * 100

func _on_enemy_container_wave_end() -> void:
	var buildings = get_tree().get_nodes_in_group("buildings")
	for building in buildings:
		if building.pollution:
			addPollution(building.pollution)
		if building.energy_generated:
			addEnergy(building.energy_generated)
