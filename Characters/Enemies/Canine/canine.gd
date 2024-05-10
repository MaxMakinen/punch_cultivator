extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const MOVEMENT_SPEED = 190.0

var speed: int = MOVEMENT_SPEED
var health: int = 5
var target: CharacterBody2D = null
var hurt: bool = false
var target_in_attack_zone: bool = false

signal enemy_dead()

func set_target(new_target: CharacterBody2D) -> void:
	target = new_target

func initialize(new_target: CharacterBody2D, new_position: Vector2) -> void:
	set_target(new_target)
	position = new_position

func _choose_direction() -> void:
	var direction: Vector2 = target.position - self.position
	velocity = direction.normalized() * speed
	if direction.x > 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false


func _physics_process(_delta: float) -> void:
	_handle_attack()
	_choose_direction()
	move_and_slide()

# Reduce heatlh by taken damage
func _take_damage(damage: int) -> void:
	health -= damage

# If health reaches zero, delete node
func _check_health() -> void:
	if health <= 0:
		enemy_dead.emit()
		queue_free()
	hurt = false
	speed = MOVEMENT_SPEED

#function for taking damage
func get_attacked(attack: Dictionary) -> bool:
	hurt = true
	speed = 0
	_take_damage(attack["damage"])
	sprite_flash()
	await get_tree().create_timer(0.25).timeout
	_check_health()
	return true

# Flash the sprite white, used when taking damage
func sprite_flash() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(sprite_2d, "modulate:v", 1, 0.25).from(15)

# Check if we have a valiod target and whether the target is in the attack zone
func _handle_attack() -> void:
	if target != null and target_in_attack_zone == true:
		target.take_damage(1)
		speed = 0
		await get_tree().create_timer(0.25).timeout
		speed = MOVEMENT_SPEED

# When the target enters the hitbox, turn on target_in_attack_zone to enable ability to attack
func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target_in_attack_zone = true

# When the target leaves the hitbox, turn off target_in_attack_zone to stop ability to attack
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		target_in_attack_zone = false

