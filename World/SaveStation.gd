extends StaticBody2D

var PlayerStats = ResourceLoader0.PlayerStats
var save_enabled = false

onready var animationPlayer = $AnimationPlayer
# warning-ignore-all:unused_argument

func _process(delta):
	if Input.is_action_just_pressed("conversar") and save_enabled:
		save_game()

# warning-ignore-all:unused_argument
func _on_SaveArea_body_entered(body):
	#if Input.is_action_pressed("savey"):
	save_enabled = true

func _on_SaveArea_body_exited(body):
	save_enabled = false

func save_game():
	SoundFx.play("Sino")
	SaverAndLoader.save_game()
	animationPlayer.play("save")
	PlayerStats.refill_stats()
