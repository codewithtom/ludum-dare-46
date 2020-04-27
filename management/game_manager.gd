extends Node
class_name GameManager

signal wave_started
signal preparation_started

export var initial_wait_time = 2
export var preparation_time = 2
onready var ui = $"../UI"

var wave = 0
var remaining_enemy_spawns = 0
var wave_in_progress = false

func _ready():
	yield(get_tree().create_timer(initial_wait_time), "timeout")
	begin_new_wave()

func _process(delta):
	if wave_in_progress and remaining_enemy_spawns == 0:
		var enemies_remaining = get_tree().get_nodes_in_group("enemies").size()
		if enemies_remaining == 0:
			begin_new_wave()

func begin_new_wave():
	wave_in_progress = false
	wave += 1
	remaining_enemy_spawns = wave * 2
	
	emit_signal("preparation_started")
	ui.add_notification("Wave %d starting in %d seconds" % [wave, preparation_time])
	ui.add_notification("Prepare your defenses!")
	yield(get_tree().create_timer(preparation_time - 3), "timeout")
	ui.add_notification("3")
	yield(get_tree().create_timer(1), "timeout")
	ui.add_notification("2")
	yield(get_tree().create_timer(1), "timeout")
	ui.add_notification("1")
	yield(get_tree().create_timer(1), "timeout")
	
	emit_signal("wave_started", wave)
	ui.add_notification("Wave %d beginning" % [wave])
	wave_in_progress = true
