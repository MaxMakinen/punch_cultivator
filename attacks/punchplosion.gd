extends Node2D

var target_pos: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("PUNCH!")
	self.position = target_pos
	$CPUParticles2D.emitting = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $CPUParticles2D.emitting == false:
		queue_free()

func set_pos(new_pos: Vector2) -> void:
	target_pos = new_pos
