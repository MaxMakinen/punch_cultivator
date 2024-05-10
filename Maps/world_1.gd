extends Node2D

@onready var level_timer: Timer = $LevelTimer
@onready var timer_label: Label = $Player/Camera2D/TimerLabel
@onready var progress_bar: ProgressBar = $Player/Camera2D/ProgressBar
@onready var player: CharacterBody2D = $Player

@export var time: int = 30
@export var hostile: PackedScene = null

const ENEMY = preload("res://characters/Enemies/Enemy.tscn")
var spawning: bool = false
var weapon: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_timer.start(time * 60)
	weapon = player.get_weapon()
	progress_bar.max_value = weapon.get_max_cooldown()

func _process(_delta: float) -> void:
	timer_label.text = _get_time()
	progress_bar.value = progress_bar.max_value - weapon.get_cooldown()
	if !spawning:
		spawning = true
		enemy_spawner()


func _get_time() -> String:
	var minutes: int = int(level_timer.time_left / 60.0)
	var seconds: int = int(level_timer.time_left) % 60
	return str(minutes) + ":" + str(seconds)

# TODO: Needs to be it's own better thing
func enemy_spawner():
	var enemy
	if hostile == null:
		enemy = ENEMY.instantiate()
	else:
		enemy = hostile.instantiate()
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var spawn_dir : Vector2 = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0))
	enemy.position = player.position + spawn_dir.normalized() * 400
	enemy.set_target(player)
	add_child(enemy)
	await get_tree().create_timer(2.0).timeout
	spawning = false

func spawn_shit(shit) -> void:
	add_child(shit)
