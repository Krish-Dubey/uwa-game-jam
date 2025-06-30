extends Control

@export var economy_script : Node

@export var label_name : Label
@export var label_hp : Label
@export var label_dmg : Label
@export var label_tooltip : Label
@export var label_cost : Label
@export var label_cash : Label

var ui_cash = 0
var ui_name = "Hover on Building"
var ui_hp = ""
var ui_dmg = ""
var ui_tooltip = ""
var ui_cost = ""

func _process(delta: float) -> void:
	
	
	label_cash.text = str(economy_script.ConstructionCash)
	label_name.text = ui_name
	label_hp.text = str(ui_hp)
	label_dmg.text = str(ui_dmg)
	label_tooltip.text = ui_tooltip
	label_cost.text = str(ui_cost)
