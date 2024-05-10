extends CharacterBody2D


@export var speed = 200
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_cooldown: Timer = $DamageCooldown

@onready var muzzle: Marker2D = $Muzzle

@export var equipped_weapon : PackedScene = null


var shot : bool = false
var dir: Vector2 = Vector2.ZERO
var weapon: Node2D

signal direction_changed(dir)

func _ready() -> void:
	weapon = equipped_weapon.instantiate()
	add_child(weapon)


func _get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		dir = input_direction.normalized()
		#weapon.aim(dir)
		direction_changed.emit(dir)


func _physics_process(_delta: float) -> void:
	_check_health()
	_get_input()
	move_and_slide()


func take_damage(damage: int) -> void:
	if damage_cooldown.is_stopped():
		Global.player_health -= damage
		print("HEALTH: ", Global.player_health)
		damage_cooldown.start()


func _check_health() -> void:
	if Global.player_health <= 0:
		print("YER DEAD!")
		get_tree().quit()


func get_weapon() -> Node2D:
	return weapon
