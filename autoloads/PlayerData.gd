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

var atk_up_mult: Dictionary = {
	"ID" : "atk_up_mult",
	"name" : "Attack power boost by 10%",
	"multiplier" : 0.1,
	"type" : "damage",
}

var speed_up_mult: Dictionary = {
	"ID" : "speed_up_mult",
	"name" : "Movement speed boost by 10%",
	"multiplier" : 0.1,
	"type" : "move_speed",
}

var cooldown_down_mult: Dictionary = {
	"ID" : "cooldown_down_mult",
	"name" : "Cooldown lowered by 10%",
	"multiplier" : 0.1,
	"type" : "cooldown",
}

var health_up_mult: Dictionary = {
	"ID" : "health_up_mult",
	"name" : "Increase health 10%",
	"multiplier" : 0.1,
	"type" : "health",
}



var player_dict: Dictionary

var player_health: int = 10
var player_max_health: int = 10
var player_move_speed: float = 200.0

# TODO: Should the base values be constants?
var _max_health: float = 10.0
var _move_speed: float = 200.0

var _health: float = 10.0


var _permanent_attack_modifiers: Array = []
var _permanent_speed_modifiers: Array = []
var _permanent_health_modifiers: Array = []


var _temporary_attack_multipliers: Array = []
var _temporary_speed_multipliers: Array = []
var _temporary_health_multipliers: Array = []


func add_mult(multiplier: Dictionary) -> void:
	if multiplier["ID"] == "atk_up_mult":
		add_to_temporary_attack_multipliers(multiplier)
	elif multiplier["ID"] == "cooldown_down_mult":
		add_to_temporary_attack_multipliers(multiplier)
	elif multiplier["ID"] == "speed_up_mult":
		add_to_temporary_speed_multipliers(multiplier)
	elif multiplier["ID"] == "health_up_mult":
		add_to_temporary_health_multipliers(multiplier)


func get_multipliers() -> Array:
	return [atk_up_mult, speed_up_mult, cooldown_down_mult, health_up_mult]


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


func get_attack() -> Dictionary:
	return attack


func get_max_health() -> float:
	return _max_health

func get_health() -> float:
	return _health

func get_move_speed() -> float:
	return _move_speed * get_move_mult()


func get_permanent_attack_modifiers() -> Array:
	return _permanent_attack_modifiers


func get_permanent_speed_modifiers() -> Array:
	return _permanent_speed_modifiers


func get_permanent_health_modifiers() -> Array:
	return _permanent_health_modifiers


func set_permanent_attack_modifiers(modifiers) -> void:
	_permanent_attack_modifiers = modifiers


func set_permanent_speed_modifiers(modifiers) -> void:
	_permanent_speed_modifiers = modifiers


func set_permanent_health_modifiers(modifiers) -> void:
	_permanent_health_modifiers = modifiers


func add_to_permanent_attack_modifiers(new_modifier) -> void:
	_permanent_attack_modifiers.append(new_modifier)


func add_to_permanent_speed_modifiers(new_modifier) -> void:
	_permanent_speed_modifiers.append(new_modifier)


func add_to_permanent_health_modifiers(new_modifier) -> void:
	_permanent_health_modifiers.append(new_modifier)

# TEMPORARY MULTIPLIERS

func get_temporary_attack_multipliers() -> Array:
	return _temporary_attack_multipliers


func get_temporary_speed_multipliers() -> Array:
	return _temporary_speed_multipliers


func get_temporary_health_multipliers() -> Array:
	return _temporary_health_multipliers

# TEMPORARY MULTIPLIER TOTALS

func get_mult_total(temporary_multipliers: Dictionary) -> float:
	var total: float = 0.0
	for mult in temporary_multipliers:
		total += mult["multiplier"]
	return total

func get_atk_dmg_mult() -> float:
	var total: float = 1.0
	for mult in _temporary_attack_multipliers:
		if mult["type"] == "damage":
			total += mult["multiplier"]
	return total

func get_move_mult() -> float:
	var total: float = 1.0
	for mult in _temporary_speed_multipliers:
		total += mult["multiplier"]
	return total


func get_health_mult() -> float:
	var total: float = 1.0
	for mult in _temporary_health_multipliers:
		total += mult["multiplier"]
	return total


func get_cooldown_mult() -> float:
	var total: float = 1.0
	for mult in _temporary_attack_multipliers:
		if mult["type"] == "cooldown":
			total -= mult["multiplier"]
	return total


func add_to_temporary_attack_multipliers(new_modifier) -> void:
	_temporary_attack_multipliers.append(new_modifier)


func add_to_temporary_speed_multipliers(new_modifier) -> void:
	_temporary_speed_multipliers.append(new_modifier)


func add_to_temporary_health_multipliers(new_modifier) -> void:
	_temporary_health_multipliers.append(new_modifier)


func clear_temporary_multipliers() -> void:
	_temporary_attack_multipliers.clear()
	_temporary_speed_multipliers.clear()
	_temporary_health_multipliers.clear()
