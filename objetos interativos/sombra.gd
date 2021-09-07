extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances

var active = false

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("conversar") and active:
#		get_tree().paused = true
		$AnimationPlayer.play("1")
	if active == false:
		$AnimationPlayer.play("0")
	if Input.is_action_just_pressed("avancar_dialogo"):
		$AnimationPlayer.play("0")
	if Input.is_action_just_pressed("conversar") and QM.chaveQuest == true:
		$AnimationPlayer.play("thanks")

func _ready():
	$AnimationPlayer.play("0")
	self.add_to_group("NPC")

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false

func _on_proceed_1_pressed():
	$AnimationPlayer.play("2")

func _on_quit_pressed():
	$AnimationPlayer.play("sumir")

func _on_proceed_2_pressed():
	$AnimationPlayer.play("3")

func _on_proceed_3_pressed():
	$AnimationPlayer.play("4")

func _on_proceed_4_pressed():
	QM.chaveQuest = true
	SoundFx.play("Powerup")
	$AnimationPlayer.play("5")

func _on_proceed_5_pressed():
	$AnimationPlayer.play("sumir")

