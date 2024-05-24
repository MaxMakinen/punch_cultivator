extends Node2D

@onready var attack_point: Marker2D = $AttackPoint
@onready var cooldown_timer: Timer = $CooldownTimer


@export var projectile: PackedScene
@export var spin_speed: float = 200
@export var spawn_dist: float = 50.0
@export var amount: int = 1

var cooldown = 3

var rear_guard: Dictionary = {
	"name" : "Rear Guard",
	"damage" : 10,
	"type" : ["physical"],
	"critical_chance" : 0.1,
	}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	if Engine.is_editor_hint():
#		attack = projectile.instantiate()
#		attack.position = attack_point.position
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#rotate(spin_speed * delta)#
	rotation_degrees += spin_speed * delta
	if cooldown_timer.is_stopped():
		_spawn_blade()


func get_cooldown() -> float:
	return cooldown_timer.time_left

func get_max_cooldown() -> float:
	return cooldown

func _spawn_blade() -> void:
	var spawn_point: Vector2 = Vector2.RIGHT
	var radian: float = deg_to_rad(360.0 / amount)
	for index in amount:
		var attack = projectile.instantiate()
		attack.set_speed(0)
		attack.set_animation("throwing_star")
		attack.set_attack(rear_guard)
		#attack_point.add_child(attack)
		attack.set_pos(spawn_point * spawn_dist)
		add_child(attack)
		spawn_point = spawn_point.rotated(radian)
	cooldown_timer.start(cooldown)

func upgrade_amount() -> void:
	amount += 1
