extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 250.0

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


func _check_health() -> void:
	if health <= 0:
		queue_free()
	hurt = false

func get_attacked(attack: Dictionary) -> bool:
	hurt = true
	_take_damage(attack["damage"])
	sprite_flash()
	await get_tree().create_timer(0.25).timeout
	_check_health()
	return true

func sprite_flash() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(sprite_2d, "modulate:v", 1, 0.25).from(15)
