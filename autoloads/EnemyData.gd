extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var _enemy_list: Dictionary = {}

# Return enemy dict for apprpriate danger level
func get_enemy(danger_level: int) -> Dictionary:
	var potential_enemies: Dictionary = {}
	for enemy in _enemy_list:
		if enemy["danger_level"] == danger_level:
			return enemy
			potential_enemies.merge(enemy)
	return potential_enemies


# TODO: Load enemy list from JSON file
func load_enemy_list(enemy_list_path: String) -> void:
	_enemy_list["path"] = enemy_list_path
