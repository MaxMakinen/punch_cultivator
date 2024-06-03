extends Node


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

func get_mults() -> Array:
	var mults: Array = [atk_up_mult, speed_up_mult, cooldown_down_mult, health_up_mult]
	return mults
