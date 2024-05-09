extends Area2D


@export var speed: int = 750
@export var effect: PackedScene
@onready var lifetime: Timer = $Lifetime


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
		body.queue_free()
		queue_free()
