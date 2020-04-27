extends Spatial

export var path_speed = 0.5
var enemy = preload("res://entities/enemy/enemy.tscn")
var game_manager
var path_follow

func _ready():
	game_manager = get_node("/root/World/GameManager")
	game_manager.connect("wave_started", self, "_on_game_manager_wave_started")
	game_manager.connect("preparation_started", self, "_on_game_manager_preparation_started")
	path_follow = get_parent()

func _process(delta):
	path_follow.unit_offset += path_speed * delta

func _on_game_manager_preparation_started():
	$Timer.stop()
	
func _on_game_manager_wave_started(wave):
	$Timer.start()
	
func _on_Timer_timeout():
	if game_manager.remaining_enemy_spawns > 0:
		game_manager.remaining_enemy_spawns -= 1
		var enemy_instance = enemy.instance()
		enemy_instance.global_transform.origin = global_transform.origin
		get_tree().get_root().get_node("World").add_child(enemy_instance)
