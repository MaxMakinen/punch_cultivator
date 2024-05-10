class_name WeaponDetecting
extends Node2D


@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle: Marker2D = $Muzzle
@export var projectile: PackedScene
@export var cooldown: float = 0.6

var shot: bool = false
var dir: Vector2 = Vector2.ZERO
var enemy_in_attack_zone: bool = false
var valid_targets: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.wait_time = cooldown



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemy_in_attack_zone == true:
		if cooldown_timer.is_stopped():
			for target in valid_targets:
				_aim(target.position)
				shoot()



func _aim(direction: Vector2) -> void:
	look_at(direction)



func shoot() -> void:
	if cooldown_timer.is_stopped():
		var b = projectile.instantiate()
		get_parent().call_deferred("add_sibling", b)
		b.transform = muzzle.global_transform
		cooldown_timer.start(cooldown)


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


func _on_target_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_attack_zone = true
		_add_enemy_to_targets(body)



func _on_target_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		_remove_from_targets(body)
		if valid_targets.is_empty():
			enemy_in_attack_zone = false
		
