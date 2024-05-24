extends Area2D

var attack: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_get_attack()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _get_attack() -> void:
	attack = Global.punch

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		Global.attack_handler(body, attack)

