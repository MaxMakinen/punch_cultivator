class_name WeaponDetecting
extends Node2D

@onready var combo_timer: Timer = $ComboTimer
#@export var combo_cooldown: float = 0.2

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle: Marker2D = $Muzzle
@export var projectile: PackedScene
#@export var cooldown: float = 1.0

#@export var combo_max: int = 2
var combo_spent: int = 0


var shot: bool = false
var enemy_in_attack_zone: bool = false
var can_attack: bool = true
var dir: Vector2 = Vector2.ZERO
var valid_targets: Array[Node2D] = []

var attack: Dictionary = {
	"name" : "punch",
	"damage" : 10,
	"type" : ["physical"],
	"critical_chance" : 0.1,
	"speed" : 250,
	"range" : 0.5,
	"cooldown" : 1.0,
	"combo_cooldown" : 0.3,
	"combo_max" : 2,
}

func get_deets() -> Dictionary:
	return attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#cooldown_timer.wait_time = cooldown
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _attack_possible():
		_attack()


func _attack() -> void:
	for target in valid_targets:
		if can_attack:
			_aim(target.position)
			if combo_timer.is_stopped():
				if cooldown_timer.is_stopped() or combo_spent < attack["combo_max"]:
					shoot()


func _aim(direction: Vector2) -> void:
	look_at(direction)

func _attack_possible() -> bool:
	if enemy_in_attack_zone == true:
		return true
	return false

func shoot() -> void:
	can_attack = false
	
	combo_spent += 1
	
	var b = projectile.instantiate()
	b.initialize(attack)
	get_parent().call_deferred("add_sibling", b)
	b.transform = muzzle.global_transform
	b.projectile_despawned.connect(attack_finished)
	
	_start_timers()

func _start_timers() -> void:
	combo_timer.start(attack["combo_cooldown"])
	if cooldown_timer.is_stopped():
		cooldown_timer.start(attack["cooldown"])

func attack_finished() -> void:
	can_attack = true

func get_cooldown() -> float:
	return cooldown_timer.time_left

func get_max_cooldown() -> float:
	return attack["cooldown"]

func _add_enemy_to_targets(enemy: Node2D) -> void:
	valid_targets.append(enemy)
	enemy.enemy_dead.connect(_remove_from_targets)


func _remove_from_targets(enemy: Node2D) -> void:
	if enemy in valid_targets:
		valid_targets.erase(enemy)
		if enemy.is_connected("enemy_dead", _remove_from_targets):
			enemy.enemy_dead.disconnect(_remove_from_targets)
	if valid_targets.is_empty():
			enemy_in_attack_zone = false


func _on_target_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_attack_zone = true
		_add_enemy_to_targets(body)
		if not body.is_connected("enemy_dead", _remove_from_targets):
			body.enemy_dead.connect(_remove_from_targets)


func _on_target_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		_remove_from_targets(body)
		if valid_targets.is_empty():
			enemy_in_attack_zone = false


func _on_cooldown_timer_timeout() -> void:
	can_attack = true
	combo_spent = 0


func upgrade_amount() -> void:
	attack["cooldown"] *= 0.9
	if attack["cooldown"] / attack["combo_max"] < attack["combo_cooldown"]:
		attack["combo_cooldown"] = attack["cooldown"] / attack["combo_max"]
	upgrade_speed()

func upgrade_combo_cooldown(combo_cooldown_increase: float = 0.9) -> void:
	attack["combo_cooldown"] *= combo_cooldown_increase

func upgrade_cooldown(cooldown_increase: float = 0.9) -> void:
	attack["cooldown"] *= cooldown_increase

func upgrade_speed(speed_increase: int = 20) -> void:
	attack["speed"] += speed_increase

func upgrade_range(range_increase: float = 0.1) -> void:
	attack["range"] += range_increase

func upgrade_combo(combo_increase: int = 1) -> void:
	attack["combo_max"] += combo_increase
