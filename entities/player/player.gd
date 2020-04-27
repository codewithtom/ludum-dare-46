extends Entity

export var walk_speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera

var camera_x_rotation : int
var velocity : Vector3
var target_velocity : Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)	

func _process(delta):
	handle_input()
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	handle_movement(delta)

func _input(event):
	handle_mouse(event)

func handle_input():
	target_velocity = Vector3()
	
	var head_basis = $Head.global_transform.basis
	
	var speed = walk_speed
	if Input.is_action_pressed("walk_forward"):
		target_velocity += -head_basis.z
	if Input.is_action_pressed("walk_backward"):
		target_velocity += head_basis.z
	if Input.is_action_pressed("strafe_left"):
		target_velocity += -head_basis.x
	if Input.is_action_pressed("strafe_right"):
		target_velocity += head_basis.x
	
	target_velocity = target_velocity.normalized() * speed

func handle_movement(delta):
	velocity = lerp(velocity, target_velocity, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	move_and_slide(velocity, Vector3.UP)

func handle_mouse(event):
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90: 
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta


func _on_Crystal_died():
	get_tree().change_scene("res://scenes/game_over.tscn")


func _on_Player_died():
	get_tree().change_scene("res://scenes/game_over.tscn")
