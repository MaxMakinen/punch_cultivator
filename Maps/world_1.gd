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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = _get_time()
	if !spawning:
		spawning = true
		enemy_spawner()
		print("SPAWN")



func _get_time() -> String:
	var min: int = int(level_timer.time_left / 60.0)
	var sec: int = int(level_timer.time_left) % 60
	return str(min) + ":" + str(sec)

func enemy_spawner():
	var enemy = ENEMY.instantiate()
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var spawn_dir : Vector2 = Vector2(rng.randf_range(-1.0, 1.0), rng.randf_range(-1.0, 1.0))
	enemy.position = player.position + spawn_dir.normalized() * 400
	add_child(enemy)
	await get_tree().create_timer(2.0).timeout
	spawning = false
	
