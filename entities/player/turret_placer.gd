extends Node

var turret = preload("res://entities/turret/turret.tscn")

export var fire_rate = 1
export var max_turrets = 3

var can_fire = true
var camera
var turrets_placed = 0

func _ready():
	camera = get_parent().get_node("Head/Camera")

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("place_turret"):
			place_turret()

func place_turret():
	if turrets_placed < max_turrets:
		turrets_placed += 1
		var turret_instance = turret.instance()	
		var position = $"../Head/Camera/RayCast".get_collision_point()
		print(position)
		turret_instance.global_transform.origin = position
		get_tree().get_root().get_node("World").add_child(turret_instance)
	
