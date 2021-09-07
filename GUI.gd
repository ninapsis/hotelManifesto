extends CanvasLayer

func _physics_process(delta):
	if Input.is_action_just_pressed("questy"):
		SoundFx.play("Vuash", rand_range(0.6, 1.2), -10)
		$AnimationPlayer.play("uno")
		$QuestLog.visible = !$QuestLog.visible
