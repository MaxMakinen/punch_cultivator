extends CharacterBody2D


const SPEED = 300.0

var target: CharacterBody2D = self

func set_target(new_target: CharacterBody2D) -> void:
	target = new_target

func _choose_direction() -> void:
	var direction: Vector2 = target.position - self.position
	velocity = direction.normalized() * SPEED

func _physics_process(_delta: float) -> void:
	_choose_direction()
	move_and_slide()
