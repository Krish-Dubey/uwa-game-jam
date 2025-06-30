extends Node

@export var EnergyBar : ProgressBar
@export var PollutionBar : ProgressBar

var ConstructionCash = 500
var EnergyGenerated = 0
var CurrentPollution = 0

var PollutionLevel = 1
var EnergyQuotaLevel = 1

func addPollution(pollution):
	CurrentPollution += pollution
	PollutionBar.value = pollution

func addEnergy(energy):
	EnergyGenerated += energy
	EnergyBar.value = energy
