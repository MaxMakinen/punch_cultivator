extends ColorRect

@export var new_weapon: PackedScene
var check: bool = false

func _on_button_pressed() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if !check:
		player.equip_weapon(new_weapon)
		check = true
	else:
		player.get_weapun().upgrade_amount()
	_unpause()


func _unpause() -> void:
	owner.get_tree().paused = false
	hide()
