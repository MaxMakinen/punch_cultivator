extends Node

const EXP_NODE = preload("res://pickups/exp_node.tscn")
const PUNCHPLOSION = preload("res://attacks/punchplosion.tscn")
const LEVEL_UP = preload("res://menus/levelUp/level_up.tscn")

var difficulty: int = 0


var punch: Dictionary = {
	"name" : "punch",
	"damage" : 5.0,
	"scene" : PUNCHPLOSION,
	"type" : ["physical"],
	"critical_chance" : 0.1,
}

var attack_dict: Dictionary = {
	"name" : "punch",
	"damage" : 10.0,
	"type" : ["physical"],
	"critical_chance" : 0.1,
	"speed" : 250,
	"range" : 0.5,
	"cooldown" : 1.0,
	"combo_cooldown" : 0.3,
	"combo_max" : 2,
}



# Increase experience and level up player if limit reached
func gain_exp(new_exp: int) -> void:
	PlayerData.change_experience(new_exp)


# Spawn experience drop
func spawn_exp(pos: Vector2, value: int) -> Node2D:
	var exp_node = EXP_NODE.instantiate()
	exp_node.initialize(pos, value)
	return exp_node


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
		var damage : float = attack["damage"]
		if not target.is_in_group("player"):
			damage = (damage + PlayerData.get_atk_dmg_mod()) * PlayerData.get_atk_dmg_mult()
		if can_resist(attack["type"], resistances):
			damage *= 0.5
		var is_critical: bool
		is_critical = float(attack["critical_chance"]) > randf()
		if is_critical == true:
			damage *= 2
		target.take_damage(damage, is_critical)
		return true
	return false
