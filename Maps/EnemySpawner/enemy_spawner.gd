extends Node2D

# ONREADY
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_path: Path2D = $SpawnPath
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation

# EXPORTS
@export var hostile: PackedScene = null
@export var player: CharacterBody2D
@export var enemy_container: Node2D

# VARIABLES
var spawn_wave_size: int = 1
var spawning: bool = false
var max_enemy_amount: int = 10
var enemy_amount: int = 0

# PRIVATE FUNCTIONS
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_wave()
	spawn_timer.start()

# Handle spawning in monsters.
func _on_spawn_timer_timeout() -> void:
	_spawn_wave()

# Spawn in next wave of enemies
func _spawn_wave() -> void:
	# Create a new instance of our hostile entity.
	var wave: Array[CharacterBody2D] = []
	for index in spawn_wave_size:
		if enemy_amount < max_enemy_amount:
			enemy_amount += 1
			wave.append(hostile.instantiate())
	for mob in wave:
		# Give it a random offset
		spawn_location.progress_ratio = randf()
		mob.initialize(player, spawn_location.global_position)
		enemy_container.add_child(mob)
		mob.enemy_dead.connect(_remove_enemy)
	# Increase the size of nect wave
	_spawn_wave_increase()

# Increase next wave size up to size 10
func _spawn_wave_increase() -> void:
	if spawn_wave_size < 10:
		spawn_wave_size += 1


func _remove_enemy(_enemy: Node2D) -> void:
	enemy_amount -= 1

# PUBLIC FUNCTIONS
func get_wave_size() -> int:
	return spawn_wave_size
