extends Node


var _enemy_list: Dictionary = {}

var bite: Dictionary = {
	"name" : "Bite",
	"damage" : 1,
	"type" : ["physical"],
	"critical_chance" : 0.0,
}

var canine: Dictionary = {
	"max_health" : 5,
	"move_speed" : 150,
	"attack" : bite,
	"danger_level" : 1,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_enemy_list["canine"] = canine
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Return enemy dict for apprpriate danger level
func get_enemy(danger_level: int) -> Dictionary:
	var potential_enemies: Dictionary = {}
	for enemy in _enemy_list:
		if enemy["danger_level"] == danger_level:
			return enemy
			potential_enemies.merge(enemy)
	return potential_enemies

func get_attack() -> Dictionary:
	return canine["attack"]

# TODO: Load enemy list from JSON file
func load_enemy_list(enemy_list_path: String) -> void:
	_enemy_list["path"] = enemy_list_path
