extends Control

var notification = preload("res://ui/notification.tscn")

func _on_Crystal_init(health, max_health):
	var lifeforce_string = "Crystal Lifeforce: %d" % health
	var lifeforce_time_string = "Crystal Lifeforce Time Remaining: %s:%s" % [str(health / 60).pad_zeros(2), str(str(health % 60).pad_zeros(2))]
	$CrystalLabel.text = "%s\n%s" % [lifeforce_string, lifeforce_time_string]
	
func _on_Crystal_took_damage(damage, health, max_health):
	var lifeforce_string = "Crystal Lifeforce: %d" % health
	var lifeforce_time_string = "Crystal Lifeforce Time Remaining: %s:%s" % [str(health / 60).pad_zeros(2), str(str(health % 60).pad_zeros(2))]
	$CrystalLabel.text = "%s\n%s" % [lifeforce_string, lifeforce_time_string]

func _on_Player_init(health, max_health):
	var s = "%d/%d HP" % [health, max_health]
	$PlayerHealthLabel.text = s


func _on_Player_took_damage(damage, health, max_health):
	var s = "%d/%d HP" % [health, max_health]
	$PlayerHealthLabel.text = s

func add_notification(text):
	var notification_instance = notification.instance()
	notification_instance.text = text
	$NotificationContainer/NotificationsBox.add_child(notification_instance)
