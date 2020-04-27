extends Node

var bullet = preload("res://entities/player/bullet.tscn")

export var fire_rate = 0.2

var can_fire = true
var camera

func _ready():
	camera = get_parent().get_node("Head/Camera")
	
func _physics_process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		can_fire = false
		fire()
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.global_transform = camera.global_transform
	get_tree().get_root().get_node("World").add_child(bullet_instance)
