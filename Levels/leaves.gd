extends Node2D
# warning-ignore-all:unused_argument
func _on_Area2D_body_entered(body):
	SoundFx.play("Leaves", rand_range(0.6, 1.0))
	$AnimationPlayer.play("New Anim")

