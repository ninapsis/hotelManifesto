extends Sprite
#var MainInstances = ResourceLoader.MainInstances

var dialog = ["Fish"]
var active = false
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("conversar") and active:
		Dialog_Start()

func _ready():
	self.add_to_group("NPC")

func Dialog_Start():
	ND.NPCDialog = dialog
	get_tree().call_group("GUI_Dialog", "reset")
# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false
