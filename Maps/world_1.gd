extends Node2D

@onready var level_timer: Timer = $LevelTimer
@onready var spawn_timer: Timer = $SpawnTimer


@onready var timer_label: Label = $Camera2D/UIRoot/TimerLabel
@onready var progress_bar: ProgressBar = $Camera2D/UIRoot/ProgressBar
@onready var exp_number: Label = $Camera2D/UIRoot/ExpNumber
@onready var main_menu: Panel = $Camera2D/UIRoot/MainMenu

@onready var player: CharacterBody2D = $Player
@onready var spawn_location: PathFollow2D = $Player/SpawnPath/SpawnLocation
@onready var enemies: Node2D = $Enemies



@export var time: int = 30
@export var hostile: PackedScene = null

const ENEMY = preload("res://characters/Enemies/Enemy.tscn")
var spawning: bool = false
var weapon: Node2D
var spawn_wave_size: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu.hide()
	player.death_signal.connect(_pause)
	level_timer.start(time * 60)
	weapon = player.get_weapon()
	progress_bar.max_value = weapon.get_max_cooldown()
	_spawn_wave()

func _process(_delta: float) -> void:
	timer_label.text = _get_time()
	progress_bar.value = progress_bar.max_value - weapon.get_cooldown()
	exp_number.text = "EXP: " + str(Global.get_exp())


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused == true:
			_unpause()
		else:
			_pause()

func _pause() -> void:
	get_tree().paused = true
	main_menu.show()

func _unpause() -> void:
	get_tree().paused = false
	main_menu.hide()

func _get_time() -> String:
	var minutes: int = int(level_timer.time_left / 60.0)
	var seconds: int = int(level_timer.time_left) % 60
	return str(minutes) + ":" + str(seconds)


# Handle psawning in monsters.
func _on_spawn_timer_timeout() -> void:
	_spawn_wave()


func _spawn_wave() -> void:
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
		enemies.add_child(mob)
	# Increase the size of nect wave
	spawn_wave_size += 1
