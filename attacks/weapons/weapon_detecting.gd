class_name WeaponDetecting
extends Node2D


@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle: Marker2D = $Muzzle
@export var projectile: PackedScene
@export var cooldown: float = 0.6
@export var combo_cooldown: float = 0.1

@export var combo_max: int = 2
var combo_spent: int = 0

var attacks_out: int = 0

var shot: bool = false
var enemy_in_attack_zone: bool = false
var can_attack: bool = true
var dir: Vector2 = Vector2.ZERO
var valid_targets: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.wait_time = cooldown



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _attack_possible():
		if cooldown_timer.is_stopped():
			if can_attack:
				_attack()
		elif combo_spent < combo_max:
			if can_attack:
				_attack()


func _attack() -> void:
	for target in valid_targets:
		_aim(target.position)
		shoot()
#	if can_attack:
#		combo_spent += 1
#		shoot()
#	elif combo_spent < combo_max:
#		combo_spent += 1
#		shoot()

func _aim(direction: Vector2) -> void:
	look_at(direction)

func _attack_possible() -> bool:
	if enemy_in_attack_zone == true:
		return true
	return false

func shoot() -> void:
	#if can_attack:
	can_attack = false
	
	var b = projectile.instantiate()
	get_parent().call_deferred("add_sibling", b)
	
	combo_spent += 1
	attacks_out += 1
	
	b.transform = muzzle.global_transform
	b.projectile_despawned.connect(start_cooldown)
	#start_cooldown()

func start_cooldown() -> void:
	attacks_out -= 1
	if attacks_out <= 0:
		attacks_out = 0
	cooldown_timer.start(cooldown)
	can_attack = true

func get_cooldown() -> float:
	return cooldown_timer.time_left

func get_max_cooldown() -> float:
	return cooldown

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
		body.enemy_dead.connect(_remove_from_targets)


func _on_target_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		_remove_from_targets(body)
		if valid_targets.is_empty():
			enemy_in_attack_zone = false


func upgrade_amount() -> void:
	cooldown *= 0.9


func _on_cooldown_timer_timeout() -> void:
	can_attack = true
	combo_spent = 0
