extends Node2D

@onready var level_timer: Timer = $LevelTimer
@onready var button_timer: Timer = $Camera2D/UIRoot/ButtonTimer

@onready var timer_label: Label = $Camera2D/UIRoot/TimerLabel
@onready var progress_bar: ProgressBar = $Camera2D/UIRoot/ProgressBar
@onready var exp_number: Label = $Camera2D/UIRoot/ExpNumber
@onready var exp_bar: ProgressBar = $Camera2D/UIRoot/ExpBar
@onready var level_indicator: Label = $Camera2D/UIRoot/LevelIndicator
@onready var wave_label: Label = $Camera2D/UIRoot/WaveLabel

@onready var main_menu: Panel = $Camera2D/UIRoot/MainMenu
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var level_up: ColorRect = $Camera2D/UIRoot/LevelUp

@onready var player: CharacterBody2D = $Player

@export var time: int = 30

@onready var cooldown: Label = $Camera2D/UIRoot/Cooldown
@onready var cooldown_2: Label = $Camera2D/UIRoot/Cooldown2

var weapon: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	main_menu.hide()
	level_up.hide()
	Global.level_up.connect(_leveling_up)
	player.death_signal.connect(_pause)
	level_timer.start(time * 60)
	weapon = player.get_weapon()
	progress_bar.max_value = weapon.get_max_cooldown()


func _process(_delta: float) -> void:
	timer_label.text = _get_time()
	progress_bar.max_value = weapon.get_max_cooldown()
	cooldown.text = str(weapon.get_max_cooldown())
	cooldown_2.text = str(weapon.attack["combo_cooldown"])
	progress_bar.value = progress_bar.max_value - weapon.get_cooldown()
	wave_label.text = "Wave : " + str(enemy_spawner.get_wave_size())
	_check_exp()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("esc") and button_timer.is_stopped():
		if get_tree().paused == true:
			_unpause()
		else:
			_pause()
		button_timer.start()


func _check_exp() -> void:
	exp_bar.max_value = Global.level_up_at
	exp_bar.value = Global.get_exp()
	exp_number.text = "EXP : " + str(Global.get_total_exp())
	level_indicator.text = "Level : " + str(Global.get_level())
	

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

func _leveling_up() -> void:
	get_tree().paused = true
	level_up.show()
