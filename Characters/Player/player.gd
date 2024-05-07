extends CharacterBody2D


@export var speed = 300
@onready var hurt_box: Area2D = $HurtBox


func _get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(_delta: float) -> void:

	_get_input()
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	print("PAIN")
	pass # Replace with function body.
