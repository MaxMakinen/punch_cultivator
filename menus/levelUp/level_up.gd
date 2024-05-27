extends ColorRect

@export var new_weapon: PackedScene
var check: bool = true
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_button_pressed() -> void:
	if !check:
		player.equip_weapon(new_weapon)
		check = true
	else:
		player.get_weapun().upgrade_amount()
	_unpause()


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


func _on_upgrade_combo_speed_pressed() -> void:
	player.get_weapun().upgrade_combo_cooldown()
	_unpause()
	

#func upgrade_range(range_increase: float = 0.1) -> void:
#	attack["range"] += range_increase
