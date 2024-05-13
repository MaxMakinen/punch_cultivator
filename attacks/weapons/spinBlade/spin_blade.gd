extends Node2D

@onready var attack_point: Marker2D = $AttackPoint
@onready var cooldown_timer: Timer = $CooldownTimer


@export var projectile: PackedScene
@export var projectil: Projectile
@export var spin_speed: float = 2.5


var cooldown = 3

var rear_guard: Dictionary = {
	"name" : "Rear Guard",
	"damage" : 5,
	}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	if Engine.is_editor_hint():
#		attack = projectile.instantiate()
#		attack.position = attack_point.position
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_spin_blade(spin_speed * delta)
	if cooldown_timer.is_stopped():
		_spawn_blade()

func _spin_blade(spin: float) -> void:
	rotation += spin

func get_cooldown() -> float:
	return cooldown_timer.time_left

func get_max_cooldown() -> float:
	return cooldown

func _spawn_blade() -> void:
	var attack = projectile.instantiate()
	attack.set_speed(0)
	attack.set_attack(rear_guard)
	attack_point.add_child(attack)
	cooldown_timer.start(cooldown)
