extends Node



var atk_up_mod: Dictionary = {
	"ID" : "atk_up_mod",
	"name" : "Attack damage increased by 5",
	"modifier" : 5,
	"type" : "damage",
}

var speed_up_mod: Dictionary = {
	"ID" : "speed_up_mod",
	"name" : "Movement speed boost by 50",
	"modifier" : 50,
	"type" : "move_speed",
}

var cooldown_down_mod: Dictionary = {
	"ID" : "cooldown_down_mod",
	"name" : "Cooldown lowered by 0.2 seconds",
	"modifier" : 0.2,
	"type" : "cooldown",
}

var health_up_mod: Dictionary = {
	"ID" : "health_up_mod",
	"name" : "Increase health by 5 HP",
	"modifier" : 5,
	"type" : "health",
}

func get_mods() -> Array:
	var mods: Array = [atk_up_mod, speed_up_mod, cooldown_down_mod, health_up_mod]
	return mods
