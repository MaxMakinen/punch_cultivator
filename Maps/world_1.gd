extends Node2D

@onready var level_timer: Timer = $LevelTimer
@onready var timer_label: Label = $Player/Camera2D/TimerLabel
@onready var progress_bar: ProgressBar = $Player/Camera2D/ProgressBar
@onready var player: CharacterBody2D = $Player
#@onready var spawn_location: PathFollow2D = $Player/Camera2D/SpawnPath/SpawnLocation
@onready var spawn_location: PathFollow2D = $Player/SpawnPath/SpawnLocation

@export var time: int = 30
@export var hostile: PackedScene = null

const ENEMY = preload("res://characters/Enemies/Enemy.tscn")
var spawning: bool = false
var weapon: Node2D
var spawn_wave_size: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_timer.start(time * 60)
	weapon = player.get_weapon()
	progress_bar.max_value = weapon.get_max_cooldown()

func _process(_delta: float) -> void:
	timer_label.text = _get_time()
	progress_bar.value = progress_bar.max_value - weapon.get_cooldown()


func _get_time() -> String:
	var minutes: int = int(level_timer.time_left / 60.0)
	var seconds: int = int(level_timer.time_left) % 60
	return str(minutes) + ":" + str(seconds)


func spawn_shit(shit) -> void:
	add_child(shit)


# Handle psawning in monsters.
func _on_spawn_timer_timeout() -> void:
	# Create a new instance of our hostile entity.
	var wave: Array[CharacterBody2D] = []
	for index in spawn_wave_size:
		wave.append(hostile.instantiate())
	# Choose random location on the SpawnPath.
	# Store the reference to the SpawnLocation node.
#	var enemy_spawn_location = $SpawnPath/SpawnLocation
	#var enemy_spawn_location: Array[PathFollow2D] = Array[spawn_wave_size]
	#for loaction in enemy_spawn_location:
	# 	location = $SpawnPath/SpawnLocation
	
	# Give it a random offset
	for mob in wave:
		spawn_location.progress_ratio = randf()
		mob.initialize(player, spawn_location.global_position)
		#mob.position = enemy_spawn_location.position
		#mob.set_target(player)
		add_child(mob)
	# Increase the size of nect wave
	spawn_wave_size += 1
