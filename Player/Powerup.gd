extends Area2D
class_name Powerup

var PlayerStats = ResourceLoader0.PlayerStats

func _pickup():
	SoundFx.play("Powerup")
	PlayerStats.missiles += 5
