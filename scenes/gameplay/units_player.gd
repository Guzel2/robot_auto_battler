extends Node

@export var player_number = 0

var active_unit

func _ready() -> void:
	active_unit = get_children()[0]

func change_active_unit():
	await active_unit.tree_exited
	
	if get_child_count() == 0:
		print(player_number, ' lost all units')
		get_parent().set_process(false)
		return
	
	active_unit = get_children()[0]
	get_parent().player_units[player_number] = active_unit
