extends StaticBody2D
#
#var dialog = ["Citadel",
#"ou cidadela",
#"todas as drogas usadas em jogos:",
#"fallout - jet",
#"We Happy Few - Joy",
#"LISA - joy"]
var active = false

func _ready():
	self.add_to_group("NPC")

func _process(delta):
	$QuestionMark.visible = active

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("conversar") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-sombra')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false

