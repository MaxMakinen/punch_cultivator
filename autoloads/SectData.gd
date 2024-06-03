extends Node


var _total_honor: float = 0.0
var _liquidated_honor: float = 000

var _acquired_upgrades: Array = []

var _honorable_elders: Array = []
var _honorable_dead: float = 0.0

func add_honor(new_honor: float) -> void:
	_total_honor += new_honor

func add_elder(new_elder: Dictionary) -> void:
	var prepared_elder: Dictionary
	prepared_elder["contribution"] = new_elder["total_exp"] * 0.5
	prepared_elder["name"] = "Elder #" + str(_honorable_elders.size())
	_honorable_elders.append(new_elder)
	_update_honor()

func add_dead(new_dead: Dictionary) -> void:
	var honor: float = new_dead["total_exp"] * 0.1
	_honorable_dead += honor

# Calvulate total Honor in sect
func _update_honor() -> void:
	var total: float = 0.0
	# Add together Honor from all living elders
	for elder in _honorable_elders:
		total += elder["contribution"]
		# Add the contribution of the dead and store the total
	total += _honorable_dead
	_total_honor = total
	var costs: float = 0.0
	# Add together the costs opf all bought upgrades
	for upgrade in _acquired_upgrades:
		costs += upgrade["cost"]
	# Calculate the amount of honor that can still be spent
	_liquidated_honor = total - costs

func add_upgrade(new_upgrade) -> void:
	_acquired_upgrades.append(new_upgrade)
	_update_honor()

func get_elders() -> Array:
	return _honorable_elders
