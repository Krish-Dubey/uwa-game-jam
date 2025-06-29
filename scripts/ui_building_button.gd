extends Button

@export var tile_id : int
@export var placement_script : Node2D
@export var info_ui : Control

@export var building_name : String
@export var building_hp : int = 0
@export var building_dmg : int = 0
@export var building_tooltip : String
@export var building_cost : int

func _on_pressed() -> void:
	placement_script.build_mode = true
	placement_script.building_id = tile_id
	pass 


func _on_mouse_entered() -> void:
	info_ui.ui_name = building_name
	info_ui.ui_hp = building_hp
	info_ui.ui_dmg = building_dmg
	info_ui.ui_tooltip = building_tooltip
	info_ui.ui_cost = building_cost
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	info_ui.ui_name = "Hover on Building"
	info_ui.ui_hp = ""
	info_ui.ui_dmg = ""
	info_ui.ui_tooltip = ""
	info_ui.ui_cost = ""
	pass # Replace with function body.
