extends CharacterBody2D


@export var speed = 400
@onready var hurt_box: Area2D = $HurtBox

@onready var muzzle: Marker2D = $Muzzle

@export var Bullet : PackedScene
@export var Weapon : PackedScene


var shot : bool = false
var dir = Vector2.ZERO
var weapon

signal direction_changed(dir)

func _ready() -> void:
	weapon = Weapon.instantiate()
	add_child(weapon)


func _get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		dir = input_direction.normalized()
		#weapon.aim(dir)
		direction_changed.emit(dir)


func _physics_process(_delta: float) -> void:
	_get_input()
	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	print("PAIN")
	pass # Replace with function body.

