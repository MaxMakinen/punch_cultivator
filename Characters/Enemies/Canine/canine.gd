extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_numbers_origin: Node2D = $DamageNumbersOrigin
@export var critical_chance: float = 0.1

const MOVEMENT_SPEED = 150

var speed: int = MOVEMENT_SPEED
var health: int = 5
var target: CharacterBody2D = null
var hurt: bool = false
var target_in_attack_zone: bool = false

signal enemy_dead(enemy)

func set_target(new_target: CharacterBody2D) -> void:
	target = new_target

# TODO : Make enemy deets dicts? Then one node can represent any of them and be decided during initialization!
# TODO : AnimatedSprite should then contain all animations for all enemies and they'll be chosen on initialization via reference from dict. We could even modulate for easy multicolored versions.
# TODO : What all will our dict need? Speed, Health, armor, sprite. Attack_type, damage and projectile could be in weapon scene that get referenced/created via the dict
# Sets up the enemies position and target.
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
	var is_critical: bool
	is_critical = critical_chance > randf()
	if is_critical == true:
		damage *= 2
	health -= damage
	DamageNumbers.display_number(damage, damage_numbers_origin.global_position, is_critical)
	if damage >= 0:
		sprite_flash()

# If health reaches zero, delete node
func _check_health() -> void:
	if health <= 0:
		enemy_dead.emit(self)
		#var exp_node = 
		get_parent().add_child(Global.spawn_exp(position, 1))
		queue_free()
	hurt = false

# Function for taking damage
func get_attacked(attack: Dictionary) -> bool:
	hurt = true
	_take_damage(attack["damage"])
	await get_tree().create_timer(0.25).timeout
	_check_health()
	return true

# Flash the sprite white, Stop enemy movement ans animation during flash, used when taking damage.
func sprite_flash() -> void:
	var tween: Tween = create_tween()
	speed = 0
	tween.tween_property(sprite_2d, "modulate:v", 1, 0.25).from(15)
	sprite_2d.pause()
	await tween.finished
	speed = MOVEMENT_SPEED
	sprite_2d.play()

# Check if we have a valiod target and whether the target is in the attack zone
func _handle_attack() -> void:
	if target != null and target_in_attack_zone == true:
		target.take_damage(1, position)
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

