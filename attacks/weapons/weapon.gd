class_name Weapon
extends Node2D


@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle: Marker2D = $Muzzle
@export var projectile: PackedScene
@export var cooldown: float = 0.5

var shot: bool = false
var dir: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().direction_changed.connect(_aim)
	cooldown_timer.wait_time = cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(0.5).timeout
	shoot()


func _aim(direction: Vector2) -> void:
	look_at(global_position + direction.normalized())


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
