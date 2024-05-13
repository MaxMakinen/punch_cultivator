extends Node

const EXP_NODE = preload("res://pickups/exp_node.tscn")
const PUNCHPLOSION = preload("res://attacks/punchplosion.tscn")

var difficulty: int = 0
var player_health: int = 10
var player_max_health: int = 10

var total_exp: int = 0
var experience: int = 0
var player_level: int = 0
var level_up_at = 10

var player_move_speed: float = 200.0

var punch: Dictionary = {
	"name" : "punch",
	"damage" : 5,
	"scene" : PUNCHPLOSION
}

var rear_guard: Dictionary = {
	"name" : "Rear Guard",
	"damege" : 5,
	}

# Increase experience and level up player if limit reached
func gain_exp(new_exp: int) -> void:
	experience += new_exp
	if experience >= level_up_at:
		_level_up()

# return current experience level
func get_exp() -> int:
	return experience

# Spawn experience drop
func spawn_exp(pos: Vector2, value: int) -> Node2D:
	var exp_node = EXP_NODE.instantiate()
	exp_node.initialize(pos, value)
	return exp_node

# Handle leveling up the character
func _level_up() -> void:
	# increase player level
	player_level += 1
	# Keep score of total acquired experience
	total_exp += experience
	# Reset experience
	experience -= level_up_at
	# Increase new level up limit by half of current
	level_up_at += level_up_at * 0.5
