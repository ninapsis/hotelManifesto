extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances

var active = false

func _ready():
	self.add_to_group("NPC")

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("conversar") and active == true:
#		get_tree().paused = true
		$AnimationPlayer.play("1")
		SoundFx.play("Miau", rand_range(0.6, 1.2), -10)
		if QM.vendorQuest == true:
			$AnimationPlayer.play("thanks")
			$AnimationPlayer.play("cat")


func _on_Leave_pressed():
	$AnimationPlayer.play("sumir")

func _on_Give_pressed():
	if QM.chaveQuest == true:
		$AnimationPlayer.play("2")
		QM.vendorQuest = true
		SoundFx.play("Powerup")
	else:
		$AnimationPlayer.play("nofish")

func _on_2_pressed():
	$AnimationPlayer.play("sumir")
	
# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false

func _on_sorry_pressed():
	$AnimationPlayer.play("sumir")
