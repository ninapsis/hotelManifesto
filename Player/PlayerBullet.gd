extends "res://Player/Projectile.gd"


func _ready():
	SoundFx.play("Bullet", rand_range(0.5, 1), -10)
	set_process(false)
