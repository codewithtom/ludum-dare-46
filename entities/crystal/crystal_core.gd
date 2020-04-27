extends Entity

func die():
	.die()
	$LifeforceTimer.stop()

func _on_LifeforceTimer_timeout():
	take_damage(1)

func _on_GameManager_preparation_started():
	$LifeforceTimer.stop()

func _on_GameManager_wave_started(wave):
	$LifeforceTimer.start()
