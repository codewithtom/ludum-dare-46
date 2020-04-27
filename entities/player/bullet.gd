extends KinematicBody

export var speed = 100
export var damage = 1

var friendly = true

func _physics_process(delta):
	move_and_collide(-global_transform.basis.z * speed * delta)

func _on_Area_body_entered(body):
	body.take_damage(damage)
	$HitSound.play()
