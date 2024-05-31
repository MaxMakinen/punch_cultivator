extends AnimatedSprite2D


const CANINE = preload("res://characters/Enemies/Canine/canine.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Spawn in next wave of enemies
func _spawn_wave() -> void:
	# Create a new instance of our hostile entity.
	var wave: Array[CharacterBody2D] = []
	for index in spawn_wave_size:
		if enemy_amount < max_enemy_amount:
			enemy_amount += 1
			wave.append(CANINE.instantiate())
	for mob in wave:
		# Give it a random offset
		spawn_location.progress_ratio = randf()
		mob.initialize(player, spawn_location.global_position)
		enemy_container.add_child(mob)
		mob.enemy_dead.connect(_remove_enemy)
	# Increase the size of nect wave
	_spawn_wave_increase()

func spawn_mob(player: CharacterBody2D, spawn_location: Vector2) -> Node2D:
	var mob = CANINE.instantiate()
	mob.initialize(player, spawn_location)
	return self
