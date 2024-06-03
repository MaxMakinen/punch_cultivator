extends Panel

#const WORLD_1 = preload("res://maps/world_1.tscn")

signal _restart()
signal _quit()

func _input(event: InputEvent) -> void:
	if event.is_action_released("esc"):
		_unpause()


func _on_restart_button_pressed() -> void:
#	_restart.emit()
	#print(owner.name)
	#Global.restart()
	PlayerData.restart_player()
	owner.get_tree().reload_current_scene()
	#owner.get_tree().paused = false
	#_unpause()
	print("RESTART")


func _on_quit_button_pressed() -> void:
#	_quit.emit()
	#get_tree().quit()
	get_tree().change_scene_to_file("res://menus/mainMenu/main_menu.tscn")
	print("QUIT")


func _on_continue_button_pressed() -> void:
	if Global.player_health > 0:
		_unpause()



func _unpause() -> void:
	owner.get_tree().paused = false
	hide()



func _on_save_button_pressed() -> void:
	PlayerData.save_shit()
	print("SAVED GAME")
	pass # Replace with function body.
