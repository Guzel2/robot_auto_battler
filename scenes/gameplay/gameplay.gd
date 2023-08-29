extends Node2D

var player_units

var next_attacking_player = -1

var remaining_time = 0
var speed_multiplier = 1

func _ready() -> void:
	player_units = [$units_player_0.active_unit, $units_player_1.active_unit]
	calc_remaining_time()

func _process(delta: float) -> void:
	if remaining_time > 0:
		remaining_time -= delta * speed_multiplier
	else:
		remaining_time = 0
		
		perform_attacks()
		check_for_death()
		
		#wait until animations finish?
		
		calc_remaining_time()

func perform_attacks():
	if next_attacking_player >= 0:
		player_units[next_attacking_player].attack(player_units[1 - next_attacking_player])
	else:
		player_units[0].attack(player_units[1])
		player_units[1].attack(player_units[0])

func check_for_death():
	for x in range(2):
	
		if player_units[x].hp <= 0:
			print(x, ' died')
			player_units[x].die()

func calc_remaining_time():
	var p0_time = player_units[0].remaining_time
	var p1_time = player_units[1].remaining_time
	
	var difference = p0_time - p1_time
	
	if difference < 0:
		next_attacking_player = 0
	if difference > 0:
		next_attacking_player = 1
	if difference == 0:
		next_attacking_player = -1
	
	if next_attacking_player >= 0:
		remaining_time = player_units[next_attacking_player].remaining_time
		
		player_units[next_attacking_player].remaining_time = player_units[next_attacking_player].attack_time
		player_units[1 - next_attacking_player].remaining_time -= remaining_time
	else:
		remaining_time = player_units[0].remaining_time
		player_units[0].remaining_time = player_units[0].attack_time
		player_units[1].remaining_time = player_units[1].attack_time
	
	#print(remaining_time, '   ', next_attacking_player)
