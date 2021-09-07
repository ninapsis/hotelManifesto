extends CanvasLayer
#func _ready():
#	self.add_to_group("NPC")
#
#func _input(event):
#	if get_node_or_null('DialogNode') == null:
#		Dialog_Start()
#
#func unpause(timeline_name):
#	get_tree().paused = false
#
#func Dialog_Start():
#	get_tree().paused = true
#	var dialog = Dialogic.start('timeline-room2')
#	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
#	dialog.connect('timeline_end', self, 'unpause')
#	add_child(dialog)
#
#func _on_Button_pressed():
##	get_tree().paused = false
#	get_tree().change_scene("res://World.tscn")
#	queue_free()
var finished: bool = false
var talking: bool = false

func _ready():
#	get_tree().paused = true
	$RichTextLabel.visible_characters = 0
	finished = false
	talking = true

func _process(delta):
	_on_Timer_timeout()

func checklength():
	if talking == true:
		if $RichTextLabel.visible_characters == $RichTextLabel.get_total_character_count():
			finished = true

func _on_Button_pressed():
#	get_tree().paused = false
	get_tree().change_scene("res://World.tscn")
	queue_free()


func _on_Timer_timeout():
	$RichTextLabel.visible_characters += 1
