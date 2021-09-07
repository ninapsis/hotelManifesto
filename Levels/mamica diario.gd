extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances
var active = false

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("conversar") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-journal')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false

func _ready():
	self.add_to_group("NPC")

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false
