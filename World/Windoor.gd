extends Area2D

export(Resource) var connection = null
export(String, FILE, "*.tscn") var new_level_path = ""
var active = false
var MainInstances = ResourceLoader0.MainInstances
var Player = MainInstances.Player
# warning-ignore:unused_argument

func _process(delta):
	if Input.is_action_just_pressed("conversar"):
		open_door(MainInstances.Player)

# warning-ignore:unused_argument
func _on_Door_body_entered(body):
	active = true
	$AnimationPlayer.play("out")

# warning-ignore:unused_argument
func open_door(Player):
	if active == true:
		Player.emit_signal("hit_door", self)
		active = false

# warning-ignore:unused_argument
func _on_Door_body_exited(body):
	$AnimationPlayer.play("win")
	active = false
	
