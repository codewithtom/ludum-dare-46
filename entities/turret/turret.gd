extends Spatial

export var fire_rate = 1.5
export var damage = 1

var target : Node
var can_fire = true

func _physics_process(delta):
	
	if target:
		var t_origin = target.global_transform.origin
		var new_target = Vector3(t_origin.x, $TurretHead.global_transform.origin.y, t_origin.z)
		$TurretHead.look_at(new_target, Vector3.UP)
		if can_fire:
			fire()

func _on_Area_body_entered(body):
	if !target:
		target = body

func _on_Area_body_exited(body):
	if target == body:
		target = null

func fire():
	if !target:
		return

	$AudioStreamPlayer.play()
	can_fire = false
	target.take_damage(damage)
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
