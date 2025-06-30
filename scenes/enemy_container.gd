extends Node

signal wave_end
@onready var SpawnParent = get_parent()
var wave_standby = 1
func _physics_process(delta: float) -> void:
	if get_children() == [] and SpawnParent.enemy_wave == [] and wave_standby == 0:
		wave_end.emit()
		wave_standby = 1
