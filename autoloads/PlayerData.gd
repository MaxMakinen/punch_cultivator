extends Node


var attack: Dictionary = {
	"name" : "punch",
	"damage" : 10,
	"type" : ["physical"],
	"critical_chance" : 0.1,
	"speed" : 250,
	"range" : 0.5,
	"cooldown" : 1.0,
	"combo_cooldown" : 0.3,
	"combo_max" : 2,
}

var player_dict: Dictionary

var _max_health: float
var _move_speed: float
var _permanent_attack_modifiers: Dictionary = {}
var _permanent_speed_modifiers: Dictionary = {}
var _permanent_health_modifiers: Dictionary = {}

func load_player(player_save: Dictionary) -> void:
	# Load player base details from save dict
	player_dict = player_save["player_dict"]
	# These two might be pointless and could be gotten directly from the dict
	_max_health = player_save["max_health"]
	_move_speed = player_save["move_speed"]
	# Load the modifiers from the save dict for easier access
	set_permanent_attack_modifiers(player_save["permanent_attack_modifiers"])
	set_permanent_speed_modifiers(player_save["permanent_speed_modifiers"])
	set_permanent_health_modifiers(player_save["permanent_health_modifiers"])

func save_player() -> Dictionary:
	var save_dict: Dictionary = {}
	save_dict["player_dict"] = player_dict
	save_dict["permanent_attack_modifiers"] = get_permanent_attack_modifiers()
	save_dict["permanent_speed_modifiers"] = get_permanent_speed_modifiers()
	save_dict["permanent_health_modifiers"] = get_permanent_health_modifiers()
	return save_dict

func get_max_health() -> float:
	return _max_health


func get_move_speed() -> float:
	return _move_speed


func get_permanent_attack_modifiers() -> Dictionary:
	return _permanent_attack_modifiers


func get_permanent_speed_modifiers() -> Dictionary:
	return _permanent_speed_modifiers


func get_permanent_health_modifiers() -> Dictionary:
	return _permanent_health_modifiers


func set_permanent_attack_modifiers(modifiers) -> void:
	_permanent_attack_modifiers = modifiers


func set_permanent_speed_modifiers(modifiers) -> void:
	_permanent_speed_modifiers = modifiers


func set_permanent_health_modifiers(modifiers) -> void:
	_permanent_health_modifiers = modifiers


func add_to_permanent_attack_modifiers(new_modifier) -> void:
	_permanent_attack_modifiers.merge(new_modifier)


func add_to_permanent_speed_modifiers(new_modifier) -> void:
	_permanent_speed_modifiers.merge(new_modifier)


func add_to_permanent_health_modifiers(new_modifier) -> void:
	_permanent_health_modifiers.merge(new_modifier)


