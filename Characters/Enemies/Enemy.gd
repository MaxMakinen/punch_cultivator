extends CharacterBody2D
class_name Enemy


@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 300.0

var health: int = 5
var target: CharacterBody2D = self
var hurt: bool = false

func set_target(new_target: CharacterBody2D) -> void:
	target = new_target


func _choose_direction() -> void:
	var direction: Vector2 = Vector2.ZERO
	if hurt == false:
		direction = target.position - self.position
	velocity = direction.normalized() * SPEED


func _physics_process(_delta: float) -> void:
	_choose_direction()
	move_and_slide()


func _take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()


func get_attacked(attack: Dictionary) -> bool:
	var punch = attack["scene"].instantiate()
	#var punch = Global.PUNCHPLOSION.instantiate()
	punch.position = self.global_position
	print("ENEMY POS: ", self.position, " PUNCH POS: ", punch.position)
	add_child(punch)
	sprite_2d.modulate = Color.WHITE
	hurt = true
	await get_tree().create_timer(0.5).timeout
	_take_damage(attack["damage"])
#	queue_free()
	return true
	return false
