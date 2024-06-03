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




#const LEVEL_UP = preload("res://menus/levelUp/level_up.tscn")

signal level_up()

var player_dict: Dictionary

var player_health: int = 10
var player_max_health: int = 10
var player_move_speed: float = 200.0

# TODO: Should the base values be constants?
var _max_health: float = 10.0
var _move_speed: float = 200.0

var _health: float = 10.0
var _total_exp = 0
var _experience = 0
var _player_level = 0
var _level_up_at = 10

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
	return TempMults.get_mults()


func load_player(player_save: Dictionary) -> void:
	# Load player base details from save dict
	player_dict = player_save["player_dict"]
	# Load the modifiers from the save dict for easier access
	set_permanent_attack_modifiers(player_save["permanent_attack_modifiers"])
	set_permanent_speed_modifiers(player_save["permanent_speed_modifiers"])
	set_permanent_health_modifiers(player_save["permanent_health_modifiers"])


func save_player() -> Dictionary:
	var save_dict: Dictionary = {}
	player_dict["attack"] = attack
	player_dict["level"] = _player_level
	player_dict["experience"] = _experience
	player_dict["total_experience"] = _total_exp
	save_dict["player_dict"] = player_dict
	save_dict["permanent_attack_modifiers"] = get_permanent_attack_modifiers()
	save_dict["permanent_speed_modifiers"] = get_permanent_speed_modifiers()
	save_dict["permanent_health_modifiers"] = get_permanent_health_modifiers()
	return save_dict

func save_shit() -> void:
	var save_game = FileAccess.open("res://savegame.json", FileAccess.WRITE)
	var save_string = JSON.stringify(save_player())
	save_game.store_line(save_string)

func restart_player() -> void:
	_health = _max_health
	_total_exp = 0
	_experience = 0
	_player_level = 0
	_level_up_at = 10


func build_player() -> void:
	set_move_speed(get_move_mod())
	set_max_health(get_health_mod())
	set_max_combo(get_combo_mod())
	_health = _max_health


#	PLAYER EXPERIENCE

func get_experience() -> float:
	return _experience


func get_total_experience() -> float:
	return _total_exp

func change_experience(value: float) -> void:
	_experience += value
	_total_exp += value
	if _experience >= _level_up_at:
		_level_up()

func get_lvl_up_at() -> float:
	return _level_up_at

func get_level() -> float:
	return _player_level

# Handle leveling up the character
func _level_up() -> void:
	# increase player level
	_player_level += 1
	# Reset experience for level up counter
	_experience = 0
	# Increase new level up limit by half of current
	_level_up_at += _level_up_at * 0.5
	level_up.emit()


func get_attack() -> Dictionary:
	return attack


func get_max_health() -> float:
	return _max_health * get_health_mult()

func get_health() -> float:
	return _health

func change_health(value: float) -> void:
	_health += value

func get_move_speed() -> float:
	return _move_speed * get_move_mult()

func set_move_speed(new_speed: float) -> void:
	_move_speed += new_speed

func set_max_health(new_health: float) -> void:
	_max_health += new_health

func set_max_combo(new_combo: float) -> void:
	attack["combo_max"] += int(new_combo)


# GET PERMANENT MODIFIERS ARRAY

func get_permanent_attack_modifiers() -> Array:
	return _permanent_attack_modifiers


func get_permanent_speed_modifiers() -> Array:
	return _permanent_speed_modifiers


func get_permanent_health_modifiers() -> Array:
	return _permanent_health_modifiers

# SET PERMANENT MODIFIERS ARRAY

func set_permanent_attack_modifiers(modifiers: Array) -> void:
	_permanent_attack_modifiers = modifiers


func set_permanent_speed_modifiers(modifiers: Array) -> void:
	_permanent_speed_modifiers = modifiers


func set_permanent_health_modifiers(modifiers: Array) -> void:
	_permanent_health_modifiers = modifiers

# ADDING PERM MODIFIERS

func add_to_permanent_attack_modifiers(new_modifier: Dictionary) -> void:
	_permanent_attack_modifiers.append(new_modifier)


func add_to_permanent_speed_modifiers(new_modifier: Dictionary) -> void:
	_permanent_speed_modifiers.append(new_modifier)


func add_to_permanent_health_modifiers(new_modifier: Dictionary) -> void:
	_permanent_health_modifiers.append(new_modifier)


func add_to_perm_mods(new_modifier: Dictionary) -> void:
	if new_modifier["family"] == "attack":
		add_to_permanent_attack_modifiers(new_modifier)
	elif new_modifier["family"] == "speed":
		add_to_permanent_speed_modifiers(new_modifier)
	elif new_modifier["family"] == "health":
		add_to_permanent_health_modifiers(new_modifier)

# PERMANENT MODIFIER TOTALS


func get_atk_dmg_mod() -> float:
	var total: float = 0.0
	for mult in _permanent_attack_modifiers:
		if mult["type"] == "damage":
			total += mult["modifier"]
	return total


func get_move_mod() -> float:
	var total: float = 0.0
	for mult in _permanent_speed_modifiers:
		total += mult["modifier"]
	return total


func get_health_mod() -> float:
	var total: float = 0.0
	for mult in _permanent_health_modifiers:
		total += mult["modifier"]
	return total

func get_combo_mod() -> float:
	var total: float = 0.0
	for mult in _permanent_attack_modifiers:
		if mult["type"] == "combo":
			total += mult["modifier"]
	return total

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
