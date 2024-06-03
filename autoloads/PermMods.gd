extends Node



var atk_up_mod: Dictionary = {
	"name" : "Aggression",
	"ID" : "atk_up_mod",
	"description" : "Attack damage increased by 5",
	"modifier" : 5,
	"type" : "damage",
}

var speed_up_mod: Dictionary = {
	"name" : "Swiftness",
	"ID" : "speed_up_mod",
	"description" : "Movement speed boost by 50",
	"modifier" : 50,
	"type" : "move_speed",
}

var cooldown_down_mod: Dictionary = {
	"name" : "Grit",
	"ID" : "cooldown_down_mod",
	"description" : "Cooldown lowered by 0.2 seconds",
	"modifier" : 0.2,
	"type" : "cooldown",
}

var health_up_mod: Dictionary = {
	"name" : "Perseverance",
	"ID" : "health_up_mod",
	"description" : "Increase health by 5 HP",
	"modifier" : 5,
	"type" : "health",
}

var combo_up_mod: Dictionary = {
	"name" : "Determination",
	"ID" : "combo_up_mod",
	"description" : "Increase max combo by 1",
	"modifier" : 1,
	"type" : "combo",
}

func get_mods() -> Array:
	var mods: Array = [atk_up_mod, speed_up_mod, cooldown_down_mod, health_up_mod, combo_up_mod]
	return mods
