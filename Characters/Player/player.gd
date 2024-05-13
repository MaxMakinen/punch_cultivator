extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_cooldown: Timer = $DamageCooldown
@onready var pickup_zone: Area2D = $PickupZone
@onready var health_bar: ProgressBar = $HealthBar

@export var equipped_weapon : PackedScene = null

const GET_HURT_BLOOD = preload("res://attacks/effects/get_hurt_blood.tscn")

var shot : bool = false
var dir: Vector2 = Vector2.ZERO
var weapon: Node2D
var equipment: Array[Node2D] = []

signal direction_changed(dir)
signal death_signal()

func _ready() -> void:
	health_bar.max_value = Global.player_max_health
	equip_weapon(equipped_weapon)
#	weapon = equipped_weapon.instantiate()
#	equipment.append(weapon)
#	add_child(weapon)

func equip_weapon(new_weapon: PackedScene) -> void:
	weapon = new_weapon.instantiate()
	equipment.append(weapon)
	add_child(weapon)

func _get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Global.player_move_speed
	if input_direction != Vector2.ZERO:
		dir = input_direction.normalized()
		direction_changed.emit(dir)


func _physics_process(_delta: float) -> void:
	_check_health()
	_get_input()
	move_and_slide()


func take_damage(damage: int, enemy_position: Vector2) -> void:
	if damage_cooldown.is_stopped():
		var blood_effect = GET_HURT_BLOOD.instantiate()
		blood_effect.initialize(self.position, (enemy_position - position).normalized())
		add_child(blood_effect)
		Global.player_health -= damage
		print("HEALTH: ", Global.player_health)
		damage_cooldown.start()


func _check_health() -> void:
	health_bar.value = Global.player_health
	if Global.player_health <= 0:
		death_signal.emit()


func get_weapon() -> Node2D:
	return weapon

func get_weapun() -> Node2D:
	return equipment[0]

func _on_pickup_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickups"):
		area.pull_to_player(self)

