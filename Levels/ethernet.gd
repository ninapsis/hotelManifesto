extends Sprite
#var MainInstances = ResourceLoader.MainInstances
var active = false

func _input(event):
	if Input.is_action_just_pressed("conversar") and active == true:
		SoundFx.play("internet")

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false

