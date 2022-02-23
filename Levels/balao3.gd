extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances
var active = false

func _ready():
	self.add_to_group("NPC")

func _input(event):
	if get_node_or_null('DialogNode') == null:
		Dialog_Start()

func unpause(timeline_name):
	get_tree().paused = false

func Dialog_Start():
	if Input.is_action_pressed("conversar") and active:
#		if QM.MicaQuest == false: #DANDO QUEST:
		get_tree().paused = true
		var dialog = Dialogic.start('timeline-balao3')
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
		add_child(dialog)
#			QM.MicaQuest = true
#
#		elif QM.MicaQuest == true: #QUEST ABERTA
#				get_tree().paused = true
#				var dialog = Dialogic.start('timeline-alfazema-done')
#				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
#				dialog.connect('timeline_end', self, 'unpause')
#				add_child(dialog)

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false
