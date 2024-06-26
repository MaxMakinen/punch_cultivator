extends Control

@onready var max_health: Label = $ColorRect/MaxHealth
@onready var move_mult: Label = $ColorRect/MoveMult
@onready var damage_mult: Label = $ColorRect/DamageMult
@onready var health_mult: Label = $ColorRect/HealthMult
@onready var move_speed: Label = $ColorRect/MoveSpeed
@onready var cooldown_mult: Label = $ColorRect/CooldownMult
@onready var max_combo: Label = $ColorRect/MaxCombo
@onready var perm_mods: Label = $ColorRect/PermMods



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	max_health.text = "Max health : " + str(PlayerData.get_max_health())
	health_mult.text = "Health mult : " + str(PlayerData.get_health_mult())
	move_speed.text = "MoveSpeed : " + str(PlayerData.get_move_speed())
	move_mult.text = "Move mult : " + str(PlayerData.get_move_mult())
	damage_mult.text = "Damage mult : " + str(PlayerData.get_atk_dmg_mult())
	cooldown_mult.text = "Cooldown mult : " + str(PlayerData.get_cooldown_mult())
	max_combo.text = "Max combo : " + str(PlayerData.get_combo_mod() + 2)
	var names: Array = PlayerData.get_perm_mod_names()
	perm_mods.text = "Perm Mods : "
	for name in names:
		perm_mods.text += name + "\n"
