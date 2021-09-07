extends StaticBody2D

var active2 = false

func _ready():
	self.add_to_group("NPC")

func _input(event):
	if get_node_or_null('DialogNode') == null:
		Dialog_Start()

func unpause(timeline_name):
	get_tree().paused = false

func Dialog_Start():
	if Input.is_action_pressed("conversar") and active2:
#		if QM.MicaQuest == false: #DANDO QUEST:
		get_tree().paused = true
		var dialog = Dialogic.start('timeline-sombra')
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
		add_child(dialog)
		
func _on_Area2D2_body_entered(body):
	active2 = true

func _on_Area2D2_body_exited(body):
	active2 = false
