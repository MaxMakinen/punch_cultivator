extends Control

@onready var mod_buttons: VBoxContainer = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ModButtons
@onready var mod_description: Label = $ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ModDescription

const PERM_MOD_BUTTON = preload("res://menus/sectMenu/perm_mod_button.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mods: Array = PermMods.get_mods()
	for mod in mods:
		var button: Button = PERM_MOD_BUTTON.instantiate()
		button.initialize(mod)
		mod_buttons.add_child(button)
		button.give_description.connect(_update_upgrade_description)


func _update_upgrade_description(description: String) -> void:
	mod_description.text = description


func _on_retire_button_pressed() -> void:
	print("Retire ya boy")
	pass # Replace with function body.
