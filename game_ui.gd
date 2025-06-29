extends Control

var currency = 1000
var pollution = 0
var quota = 1000
var progress = float(currency)/float(quota)

@onready var currency_label = $PollutionAndCurrency/CurrencyLabel
@onready var pollution_label = $PollutionAndCurrency/PollutionLabel
@onready var progress_bar = $ProgressBar
@onready var tower_list = $ScrollContainer/VBoxContainer
@onready var scroll_container = $ScrollContainer

var towers = [
	{"name": "Gattling Gun", "cost": 100, "icon": preload("res://assets/gattling-gun.png")},
	{"name": "Factory", "cost": 200, "icon": preload("res://assets/factory/tile000.png")},
	{"name": "Air Filter", "cost": 2000, "icon": preload("res://assets/pollution-filter-w-funnel/tile000.png")},
	{"name": "Solar Panels", "cost": 2000, "icon": preload("res://new-assets/pixil-frame-0 (9).png")},
	{"name": "Cannon", "cost": 500, "icon": preload("res://new-assets/cannon.png")},
]

func _ready() -> void:
	update_currency()
	update_pollution()
	tower_list_element()
	update_progress_bar()


func update_currency():
	currency_label.text = "Currency: " + str(currency)
	
func update_pollution():
	pollution_label.text = "Pollution: " + str(pollution)

func update_progress_bar():
	#progress_bar.
	progress_bar.max_value = quota  
	progress_bar.value = currency
	
func tower_list_element():
	var scroll_container_width = scroll_container.size.x
	var tower_max_width = int(scroll_container_width / 2.0) - 40
	print(tower_max_width, " ", scroll_container_width)
	
	var button_theme = Theme.new()
	# Set the icon_max_width within the theme
	button_theme.set_constant("icon_max_width", "Button", tower_max_width)


	for tower in towers:
		var tower_button = Button.new()
		tower_button.text = tower["name"]
		tower_button.icon = tower["icon"]
		#tower_button.rect_min_size = Vector2(tower_max_width, 50)  # Adjust this to make sure button is big enough
		#tower_button.icon_alignment = HORIZONTAL_ALIGNMENT_LEFT
		
		tower_button.size_flags_horizontal = Control.SIZE_EXPAND
		#tower_button.expand_icon = true
		#print(tower["icon"])
		# remove if not work
		
		#var button_theme = Theme.new()
#
		## Set the icon_max_width within the theme
		#button_theme.set_constant("icon_max_width", "Button", tower_max_width)
		
		# Assign the theme to the button
		tower_button.theme = button_theme
		
		tower_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		tower_button.flat = true
		
		tower_button.pressed.connect(_on_tower_selected.bind(tower))
		tower_list.add_child(tower_button)

		
func _on_tower_selected(tower):
		if currency >= tower["cost"]:
			currency -= tower["cost"]
			update_currency()
			#print("Tower placed: " + tower["name"])
			#progress -= 50  
			update_progress_bar()
		# call placing on map script thingy
		else:
			
			print("Not enough currency to place " + tower["name"])
