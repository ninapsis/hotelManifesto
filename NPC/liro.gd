extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances

var quest_given: bool = false
var quest_name: String = "Defeat the Bug Boss"
var quest_des: String = "Villagers can't walk past the Cave due to a huge bug. Help them if you can."

var active = false

func _ready():
	self.add_to_group("NPC")

# warning-ignore:unused_argument

func _process(delta):
	$QuestionMark.visible = active

func _input(event):
	if get_node_or_null('DialogNode') == null:
		Dialog_Start()

func unpause(timeline_name):
	get_tree().paused = false

func Dialog_Start():
	if Input.is_action_pressed("conversar") and active:
		if quest_given == false: #DANDO QUEST:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-liro')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			QM.Quests.ActiveQuests.append(quest_name)
			QM.Quests.QuestDescription.append(quest_des)
			get_tree().call_group("Quest", "add_quest")
			add_child(dialog)
			quest_given = true
			
		elif quest_given == true and QM.LiroQuest == false: #QUEST ABERTA
				get_tree().paused = true
				var dialog = Dialogic.start('timeline-liro-open')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)

		elif quest_given == true and QM.LiroQuest == true: #QUEST CONCLUIDA
			get_tree().call_group("Quest", "remove_quest", quest_name, quest_des)
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-liro-done')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false

