extends Node


const PUNCHPLOSION = preload("res://attacks/punchplosion.tscn")

var difficulty: int = 0
var player_health: int = 10

var punch: Dictionary = {
	"name" : "punch",
	"damage" : 5,
	"scene" : PUNCHPLOSION
}

