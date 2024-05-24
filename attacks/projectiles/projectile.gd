extends Area2D
class_name Projectile

@onready var player = get_tree().get_first_node_in_group("player")
@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var lifetime: float = 1.5

var damage: int = 1
var speed: int = 50
var type: String = "blade"
var element: String = "neutral"
# How many enemies this projectile will penetrate, -1 means no limit.
var penetration: int = -1

var attack: Dictionary
var anim: String = "default"

#var attack: Dictionary = {
#	"damage" : 5,
#	"type" : ["physical"],
#}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2).from(0.0)
	lifetime_timer.start(lifetime)
	animated_sprite_2d.play(anim)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta
	if lifetime_timer.is_stopped():
		_delete_projectile()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
#		if effect != null:
#			var impact_effect = effect.instantiate()
#			get_parent().add_child(impact_effect)
#			impact_effect.position = body.global_position
		#body.get_attacked(attack)
		Global.attack_handler(body, attack)
		if penetration > 0:
			penetration -= 1
		if penetration == 0:
			queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_delete_projectile()


func _on_lifetime_timer_timeout() -> void:
	_delete_projectile()


func _delete_projectile() -> void:
	var tween: Tween = self.create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_callback(queue_free)


func set_speed(new_speed: int) -> void:
	speed = new_speed

func set_attack(new_attack: Dictionary) -> void:
	attack = new_attack

func set_animation(new_anim: String) -> void:
	anim = new_anim

func set_pos(new_pos: Vector2) -> void:
	position = new_pos
