extends Area2D
class_name Projectile

@onready var player = get_tree().get_first_node_in_group("player")
@onready var lifetime_timer: Timer = $LifetimeTimer

@export var lifetime: float = 1.5

var damage: int = 1
var speed: int = 50
var type: String = "blade"
var element: String = "neutral"
# How many enemies this projectile will penetrate, -1 means no limit.
var penetration: int = -1

var attack : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lifetime_timer.start(lifetime)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta
	if lifetime_timer.is_stopped():
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
#		if effect != null:
#			var impact_effect = effect.instantiate()
#			get_parent().add_child(impact_effect)
#			impact_effect.position = body.global_position
		body.get_attacked(attack)
		if penetration > 0:
			penetration -= 1
		if penetration == 0:
			queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_lifetime_timer_timeout() -> void:
	queue_free()

func set_speed(new_speed: int) -> void:
	speed = new_speed

func set_attack(new_attack: Dictionary) -> void:
	attack = new_attack

