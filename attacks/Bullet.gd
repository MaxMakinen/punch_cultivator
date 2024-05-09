extends Area2D


@export var speed: int = 750
@export var effect: PackedScene = null
@onready var lifetime: Timer = $Lifetime
@onready var player = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lifetime.start(3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta
	if lifetime.is_stopped():
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if effect != null:
			var impact_effect = effect.instantiate()
			get_parent().add_child(impact_effect)
			impact_effect.position = body.global_position
		body.get_attacked(Global.punch)
		#body.queue_free()
		queue_free()
