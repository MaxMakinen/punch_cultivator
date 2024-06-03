extends ColorRect

@export var new_weapon: PackedScene
var check: bool = true
var player: Node2D

@onready var button_1: Button = $MarginContainer/ColorRect/VBoxContainer/Button1
@onready var button_2: Button = $MarginContainer/ColorRect/VBoxContainer/Button2
@onready var button_3: Button = $MarginContainer/ColorRect/VBoxContainer/Button3
@onready var button_4: Button = $MarginContainer/ColorRect/VBoxContainer/Button4


var multipliers: Array
var buttons: Array = [button_1, button_2, button_3, button_4]
var menu_len: int = 4
var choices: Array = []

func _ready() -> void:
	buttons = [button_1, button_2, button_3, button_4]
	player = get_tree().get_first_node_in_group("player")
	multipliers = PlayerData.get_multipliers()
	populate_choices()
	name_buttons()


# Move population and details into script for button itself, then dyna ically create buttons through code?
func populate_choices() -> void:
	var temp: Dictionary = {}
	for index in menu_len:
		temp["button"] = buttons[index]
		temp["multiplier"] = multipliers[index]
		choices.append(temp.duplicate())


func name_buttons() -> void:
	for choice in choices:
		print(choice["multiplier"]["name"])
		print(choice["button"].text)
		
		choice["button"].text = choice["multiplier"]["name"]


func make_choice(choice: int) -> void:
	PlayerData.add_mult(multipliers[choice])
	print(multipliers[choice]["name"])
	print(choice)

func _unpause() -> void:
	owner.get_tree().paused = false
	hide()


#func _on_upgrade_cooldown_pressed() -> void:
#	_unpause()
#
#func _on_upgrade_speed_pressed() -> void:
#	player.get_weapun().upgrade_speed()
#	_unpause()
#
#
#func _on_upgrade_combo_pressed() -> void:
#	player.get_weapun().upgrade_combo()



#func upgrade_range(range_increase: float = 0.1) -> void:
#	attack["range"] += range_increase


func _on_button_1_pressed() -> void:
	make_choice(0)
	_unpause()


func _on_button_2_pressed() -> void:
	make_choice(1)
	_unpause()


func _on_button_3_pressed() -> void:
	make_choice(2)
	_unpause()


func _on_button_4_pressed() -> void:
	make_choice(3)
	_unpause()
