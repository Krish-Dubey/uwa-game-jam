extends Node

signal wave_end
@onready var SpawnParent = get_parent()
func _physics_process(delta: float) -> void:
	if get_children() == [] and SpawnParent.enemy_wave == []:
		wave_end.emit()
