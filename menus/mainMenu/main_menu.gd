extends Control

@onready var start_button: Button = $ColorRect/MarginContainer/VBoxContainer/StartButton
@onready var load_button: Button = $ColorRect/MarginContainer/VBoxContainer/LoadButton
@onready var quit_button: Button = $ColorRect/MarginContainer/VBoxContainer/QuitButton
@onready var parallax_background: ParallaxBackground = $ParallaxBackground


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/sectMenu/sect_menu.tscn")
	pass # Replace with function body.


func _on_load_button_pressed() -> void:
	print("LOAD GAME")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	print("QUIT")

