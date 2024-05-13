extends Node2D


var target_pos: Vector2 = Vector2.ZERO
var attack_direction: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position = target_pos
	$CPUParticles2D.emitting = true
	$CPUParticles2D.direction = attack_direction



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $CPUParticles2D.emitting == false:
		queue_free()


func initialize(new_pos: Vector2, direction: Vector2) -> void:
	target_pos = new_pos
	attack_direction = direction
