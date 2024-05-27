extends Node

const EXP_NODE = preload("res://pickups/exp_node.tscn")
const PUNCHPLOSION = preload("res://attacks/punchplosion.tscn")
const LEVEL_UP = preload("res://menus/levelUp/level_up.tscn")

var difficulty: int = 0
var player_health: int = 10
var player_max_health: int = 10

var total_exp: int = 0
var experience: int = 0
var player_level: int = 0
var level_up_at = 3

var player_move_speed: float = 200.0

var punch: Dictionary = {
	"name" : "punch",
	"damage" : 5,
	"scene" : PUNCHPLOSION,
	"type" : ["physical"],
	"critical_chance" : 0.1,
}

signal level_up()

# Increase experience and level up player if limit reached
func gain_exp(new_exp: int) -> void:
	experience += new_exp
	total_exp += new_exp
	if experience >= level_up_at:
		_level_up()

# Rseturn current experience level
func get_exp() -> int:
	return experience

# Return toal acquired experience points
func get_total_exp() -> int:
	return total_exp

# Return current player level
func get_level() -> int:
	return player_level

# Spawn experience drop
func spawn_exp(pos: Vector2, value: int) -> Node2D:
	var exp_node = EXP_NODE.instantiate()
	exp_node.initialize(pos, value)
	return exp_node

# Handle leveling up the character
func _level_up() -> void:
	# increase player level
	player_level += 1
	# Reset experience for level up counter
	experience -= level_up_at
	# Increase new level up limit by half of current
	level_up_at += level_up_at * 0.5
	level_up.emit()

func restart() -> void:
	player_health = 10
	player_max_health = 10
	total_exp = 0
	experience = 0
	player_level = 0
	level_up_at = 10

func can_resist(attack_types: Array, resistances: Array) -> bool:
	if attack_types.size() > 0:
		for type in attack_types:
			if type in resistances:
				return true
	return false
	

# Handle dealing damage, take in target and attack info. Apply calculated damage to target and return true if attack is valid or false if attack hits wall and should stop.
func attack_handler(target: Node2D, attack: Dictionary) -> bool:
	if target.has_method("get_resistances"):
		var resistances: Array = target.get_resistances()
		var damage = float(attack["damage"])
		if can_resist(attack["type"], resistances):
			damage *= 0.5
		var is_critical: bool
		is_critical = float(attack["critical_chance"]) > randf()
		if is_critical == true:
			damage *= 2
		target.take_damage(damage, is_critical)
		return true
	return false
