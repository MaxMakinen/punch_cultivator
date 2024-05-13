extends Node

const EXP_NODE = preload("res://pickups/exp_node.tscn")
const PUNCHPLOSION = preload("res://attacks/punchplosion.tscn")

var difficulty: int = 0
var player_health: int = 10
var player_max_health: int = 10
var experience: int = 0
var player_move_speed: float = 200.0

var punch: Dictionary = {
	"name" : "punch",
	"damage" : 5,
	"scene" : PUNCHPLOSION
}

func gain_exp(new_exp: int) -> void:
	experience += new_exp

func get_exp() -> int:
	return experience

func spawn_exp(pos: Vector2, value: int) -> Node2D:
	var exp_node = EXP_NODE.instantiate()
	exp_node.initialize(pos, value)
	return exp_node
