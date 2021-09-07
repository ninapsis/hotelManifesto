extends Powerup

func _ready():
	if SaverAndLoader.custom_data.missiles_unlocked:
		queue_free()

#DA PRA FAZER ISSO COM O DOUBLE JUMP!!!
func _pickup():
	._pickup()
	PlayerStats.missiles_unlocked = true
	PlayerStats.missiles += 1
	queue_free()
