extends Node

@export var EnergyBar : ProgressBar
@export var PollutionBar : ProgressBar
@export var EnergyText : Label
@export var PollutionText : Label

var ConstructionCash = 1000
var EnergyGenerated = 0
var CurrentPollution = 0

var PollutionLevel = 1
var EnergyQuotaLevel = 1

var buildings = []

@export var PollutionThreshold = 300
@export var QuotaThreshold = 600

func addPollution(pollution):
	CurrentPollution += pollution
	PollutionBar.value = (CurrentPollution / PollutionThreshold) * 100
	if PollutionBar.value >= 100:
		PollutionLevel += 1
		PollutionBar.value = 0
		PollutionThreshold = PollutionThreshold * 1.2
		CurrentPollution = 0
		PollutionText.text = "Pollution Level " + str(PollutionLevel)
	elif PollutionBar.value < 0 and PollutionLevel > 1:
		PollutionLevel -= 1
		PollutionBar.value = 0
		PollutionThreshold = PollutionThreshold / 1.2
		CurrentPollution = 0
		PollutionText.text = "Pollution Level " + str(PollutionLevel)

func addEnergy(energy):
	if EnergyBar.value >= 100:
		ConstructionCash += energy
	EnergyGenerated += energy 
	EnergyBar.value = (EnergyGenerated / QuotaThreshold) * 100

func _on_enemy_container_wave_end() -> void:
	buildings = get_tree().get_nodes_in_group("buildings")
	for building in buildings:
		if building.pollution:
			addPollution(building.pollution)
		if building.energy_generated:
			addEnergy(building.energy_generated)
