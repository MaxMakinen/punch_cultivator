extends Panel

#const WORLD_1 = preload("res://maps/world_1.tscn")

signal _restart()
signal _quit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused == true:
			_unpause()


func _on_restart_button_pressed() -> void:
#	_restart.emit()
	owner.get_tree().paused = false
	get_tree().reload_current_scene()
	print("RESTART")


func _on_quit_button_pressed() -> void:
#	_quit.emit()
	get_tree().quit()
	print("QUIT")



func _on_continue_button_pressed() -> void:
	_unpause()


func _unpause() -> void:
	owner.get_tree().paused = false
	hide()

