extends Node2D


var exp_value: int = 1
var pulled: bool = false
var target: CharacterBody2D

const ACCEL = 5
var speed = 0

func initialize(pos: Vector2, value: int = 1) -> void:
	exp_value = value
	position = pos

func _process(delta: float) -> void:
	if pulled:
		var direction = target.position - position
		speed = move_toward(speed, Global.player_move_speed + 10, ACCEL)
		position += direction.normalized() * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.gain_exp(exp_value)
		queue_free()

func pull_to_player(player: CharacterBody2D) -> void:
	pulled = true
	target = player
#	var tween = get_tree().create_tween()
#	tween.tween_property(self, "position", target.position, 0.3).set_ease(Tween.EASE_OUT)
#	await tween.finished

func _move_thing() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target.position, 0.3)#.set_ease(Tween.EASE_OUT)
	await tween.finished
	
