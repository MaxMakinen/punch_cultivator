extends Node2D


var exp_value: int = 1

func initialize(pos: Vector2, value: int = 1) -> void:
	exp_value = value
	position = pos


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.gain_exp(exp_value)
		queue_free()

