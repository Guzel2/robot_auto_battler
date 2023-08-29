extends Node

@export var hp = 10
@export var attack_time = .1
@export var damage = 2

var remaining_time

func _ready():
	remaining_time = attack_time

func pass_time(time: float):
	remaining_time -= time

func attack(target):
	target.hp -= damage
	remaining_time = attack_time

func die():
	queue_free()
	get_parent().change_active_unit()
