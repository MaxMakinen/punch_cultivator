extends ColorRect

@export var new_weapon: PackedScene
var check: bool = true
var player: Node2D
var multipliers: Array

@onready var button_1: Button = $MarginContainer/ColorRect/VBoxContainer/Button1
@onready var button_2: Button = $MarginContainer/ColorRect/VBoxContainer/Button2
@onready var button_3: Button = $MarginContainer/ColorRect/VBoxContainer/Button3
@onready var button_4: Button = $MarginContainer/ColorRect/VBoxContainer/Button4


var buttons: Array = [button_1, button_2, button_3, button_4]
var menu_len: int = 3
var choices: Dictionary

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	multipliers = PlayerData.get_multipliers()


# Move population and details into script for button itself, then dyna ically create buttons through code?
func populate_choices() -> void:
	for index in menu_len:
		choices["button"] = buttons[index]
		choices["multiplier"] = multipliers[index]

func make_coice(choice: int) -> void:
	PlayerData.add_mult(multipliers[choice])

func _unpause() -> void:
	owner.get_tree().paused = false
	hide()


func _on_upgrade_cooldown_pressed() -> void:
	player.get_weapun().upgrade_cooldown()
	_unpause()

func _on_upgrade_speed_pressed() -> void:
	player.get_weapun().upgrade_speed()
	_unpause()


func _on_upgrade_combo_pressed() -> void:
	player.get_weapun().upgrade_combo()
	_unpause()



#func upgrade_range(range_increase: float = 0.1) -> void:
#	attack["range"] += range_increase


func _on_button_1_pressed() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.
