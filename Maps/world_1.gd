extends Node2D

@onready var level_timer: Timer = $LevelTimer
@onready var timer_label: Label = $Player/Camera2D/TimerLabel
@onready var player: CharacterBody2D = $Player

@export var time: int = 30

const ENEMY = preload("res://characters/Enemies/Enemy.tscn")
var spawning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_timer.start(time * 60)



func _process(_delta: float) -> void:
	timer_label.text = _get_time()
	if !spawning:
		spawning = true
		enemy_spawner()
		print("SPAWN")



func _get_time() -> String:
	var minutes: int = int(level_timer.time_left / 60.0)
	var seconds: int = int(level_timer.time_left) % 60
	return str(minutes) + ":" + str(seconds)

func enemy_spawner():
	var enemy = ENEMY.instantiate()
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var spawn_dir : Vector2 = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0))
	enemy.position = player.position + spawn_dir.normalized() * 400
	enemy.set_target(player)
	add_child(enemy)
	await get_tree().create_timer(2.0).timeout
	spawning = false
	
