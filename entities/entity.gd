extends KinematicBody
class_name Entity

signal init
signal took_damage
signal died
export var health = 10
export var max_health = 10

func _ready():
	emit_signal("init", health, max_health)

func take_damage(damage):
	health -= damage
	emit_signal("took_damage", damage, health, max_health)
	
	if health <= 0:
		die()

func die():
	print(name + " died")
	emit_signal("died")
