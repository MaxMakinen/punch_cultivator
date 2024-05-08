extends Node


const PUNCHPLOSION = preload("res://attacks/punchplosion.tscn")

var difficulty: int = 0

var punch: Dictionary = {
	"name" : "punch",
	"damage" : 5,
	"scene" : PUNCHPLOSION
}

