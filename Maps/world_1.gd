extends Node2D

@onready var level_timer: Timer = $LevelTimer
@onready var timer_label: Label = $Player/Camera2D/TimerLabel

@export var time: int = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_timer.start(time * 60)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = _get_time()


func _get_time() -> String:
	var min: int = int(level_timer.time_left / 60.0)
	var sec: int = int(level_timer.time_left) % 60
	return str(min) + ":" + str(sec)
