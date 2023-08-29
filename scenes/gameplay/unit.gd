extends Node

var hp = 10
var attack_time = .1
var damage = 2

var remaining_time

var list_of_cores = [
	'glass_canon',
	'tank',
	'all_rounder',
	'speedy',
	'slowey'
]

var core_stats = {
	'glass_canon':
		{
			'hp': 10,
			'attack_time': 1.0,
			'damage': 10,
		},
	'tank':
		{
			'hp': 20,
			'attack_time': .4,
			'damage': 2,
		},
	'all_rounder':
		{
			'hp': 16,
			'attack_time': .6,
			'damage': 4,
		},
	'speedy':
		{
			'hp': 14,
			'attack_time': .3,
			'damage': 1,
		},
	'slowey':
		{
			'hp': 17,
			'attack_time': .8,
			'damage': 5,
		}
}

var list_of_arms = [
	'repair',
	'strong',
	'speed_up',
]


@export var core = 'all_rounder'
@export var left_arm = 'strong'
@export var rigth_arm = 'strong'

func _ready():
	set_core_stats()
	remaining_time = attack_time

func set_core_stats():
	hp = core_stats[core]['hp']
	attack_time = core_stats[core]['attack_time']
	damage = core_stats[core]['damage']

func pass_time(time: float):
	remaining_time -= time

func attack(target):
	target.hp -= damage + extra_damage()
	remaining_time = attack_time + extra_time()
	
	extra_effect()

func extra_damage():
	var arms = [left_arm, rigth_arm]
	var extra_damage = 0
	
	for arm in arms:
		if arm == 'strong':
			extra_damage += 2
	
	return extra_damage

func extra_time():
	var arms = [left_arm, rigth_arm]
	var time = 0
	
	for arm in arms:
		if arm == 'speed_up':
			time -= .1
	
	return time

func extra_effect():
	var arms = [left_arm, rigth_arm]
	
	for arm in arms:
		match arm:
			'repair':
				for sibling in get_parent().get_children():
					sibling.hp += 1

func die():
	queue_free()
	get_parent().change_active_unit()
