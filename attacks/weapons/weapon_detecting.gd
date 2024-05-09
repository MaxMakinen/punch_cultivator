extends Node2D


@onready var cooldown_timer: Timer = $CooldownTimer
@onready var muzzle: Marker2D = $Muzzle
@export var projectile: PackedScene
@export var cooldown: float = 0.2

var shot: bool = false
var dir: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_timer.wait_time = cooldown
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _aim(direction: Vector2) -> void:
	dir = direction.normalized()

func shoot() -> void:
	if cooldown_timer.is_stopped():
		var b = projectile.instantiate()
		look_at(self.global_position + dir)
		get_parent().call_deferred("add_sibling", b)
		b.transform = muzzle.global_transform
		cooldown_timer.start(cooldown)


func _on_target_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		_aim(body.position - self.position)
		shoot()

