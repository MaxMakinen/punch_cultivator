extends Button

var modifier: Dictionary
signal give_description(description)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize(perm_mod: Dictionary) -> void:
	modifier = perm_mod
	text = perm_mod["name"]


func _on_pressed() -> void:
	PlayerData.add_to_perm_mods(modifier)
	disabled = true
	get_tree().change_scene_to_file("res://menus/sectMenu/sect_menu.tscn")


func get_description() -> String:
	return modifier["description"]



func _on_mouse_entered() -> void:
	give_description.emit(modifier["description"])

