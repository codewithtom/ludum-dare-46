extends Entity

enum {
	PATHING,
	ATTACKING_CRYSTAL,
	ATTACKING_PLAYER
}

export var speed = 5
export var damage = 1
export var attack_rate = 1
export var attack_range = 20
export var engage_range = 50
export var disengage_range = 50

var can_attack = true
var state = PATHING
var player : Node
var crystal : Node
var game_manager : Node

func _ready():
	game_manager = get_node("/root/World/GameManager")
	player = get_node("/root/World/Player")
	crystal = get_node("/root/World/Crystal")

func _physics_process(delta):
	match state:
		PATHING:
			pathing(delta)
		ATTACKING_CRYSTAL:
			attacking_crystal(delta)
		ATTACKING_PLAYER:
			attacking_player(delta)

func pathing(delta):
	if is_in_range(crystal, engage_range):
		state = ATTACKING_CRYSTAL
	elif is_in_range(player, engage_range):
		state = ATTACKING_PLAYER
	else:
		move_towards(crystal)
		look_at(crystal.global_transform.origin, Vector3.UP)

func attacking_crystal(delta):
	if !is_in_range(crystal, disengage_range):
		state = PATHING
	elif is_in_range(crystal, attack_range):
		attack(crystal)
	else:
		move_towards(crystal)
		look_at(crystal.global_transform.origin, Vector3.UP)

func attacking_player(delta):
	if !is_in_range(player, disengage_range):
		state = PATHING
	elif is_in_range(player, attack_range):
		attack(player)
		look_at(player.global_transform.origin, Vector3.UP)
	else:
		move_towards(player)
		look_at(player.global_transform.origin, Vector3.UP)

func attack(body):
	if can_attack:
		can_attack = false
		body.take_damage(damage)
		yield(get_tree().create_timer(attack_rate), "timeout")
		can_attack = true
	
func die():
	.die()
	crystal.take_damage(-5)
	queue_free()

func is_in_range(body, r):
	return (global_transform.origin - body.global_transform.origin).length() <= r

func move_towards(body):
	var new_speed = speed * game_manager.wave
	var direction = -(global_transform.origin - body.global_transform.origin).normalized()
	direction.y = 0
	move_and_slide(direction * new_speed)
