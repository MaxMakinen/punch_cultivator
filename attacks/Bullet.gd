extends Area2D


@export var speed: int = 150
@export var effect: PackedScene = null
@onready var lifetime: Timer = $Lifetime
@onready var player = get_tree().get_first_node_in_group("player")

signal projectile_despawned()

var attack_range: float = 0.5
var attack: Dictionary = {
	"name" : "punch",
	"damage" : 10,
	"type" : ["physical"],
	"critical_chance" : 0.1,
	"speed" : 200,
	"range" : 0.5,
}

func initialize(new_attack: Dictionary) -> void:
	attack = new_attack
	speed = attack["speed"]
	attack_range = attack["range"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lifetime.start(attack_range)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta
	if lifetime.is_stopped():
		_despawn()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if effect != null:
			var impact_effect = effect.instantiate()
			get_parent().add_child(impact_effect)
			impact_effect.position = body.global_position
		Global.attack_handler(body, attack)
		#body.get_attacked(Global.punch)
		#body.queue_free()
		_despawn()

func _despawn() -> void:
	projectile_despawned.emit()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_despawn()


func _on_lifetime_timeout() -> void:
	_despawn()
