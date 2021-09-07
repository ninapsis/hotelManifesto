extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances

var active = false

func _process(delta):
	$QuestionMark.visible = active

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("conversar") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-aura')
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


#var MainInstances = ResourceLoader.MainInstances

#var dialog = ["Para atravessar o portão, você precisa quebrá-lo.",
#"Encontre esse item: [img=<30>x<25>]res://Player/PlayerMissile.png[/img]"
#var dialog = ["[color=#00C7B1]A girl in glasses. She looks relaxed.[/color]\nHi! I haven't seen you around before.",
#"[color=#00C7B1]A girl in glasses. She looks relaxed.[/color]\nWelcome to the Citadel! Everyone here is always excited to meet new people, so don't be shy.",
#"[color=#00C7B1]A girl in glasses. She looks relaxed.[/color]\nSo, I suppose you are here to upgrade your diving equipment, right? Maybe a new [color=red]Helmet[/color]? That one is cute, but a bit old.",
#"[color=#00C7B1]A girl in glasses. She looks relaxed.[/color]\nLuckily, you came to the right place! Everyone here adores a good mask",
#"[color=#00C7B1]A girl in glasses. She looks relaxed.[/color]\nTo be honest I don't really understand why, but It's okay! People should do as they please, as long as they are harmless.",
#"[color=#00C7B1]Aura. She looks relaxed.[/color]\nYou can call me [color=#00C7B1]Aura[/color], by the way. Nice to meet you!"]
#
#onready var portrait = $CanvasLayer/portrait
#var active = false
#var quest_dialog = ["[color=#00C7B1]Aura. She looks relaxed.[/color]\nGood to see you! Take care."]
#var quest_given: bool = false
#
#func _ready():
#	portrait.visible = false
#	self.add_to_group("NPC")
#
## warning-ignore:unused_argument
#func _process(delta):
#	if Input.is_action_just_pressed("conversar") and active and QM.dialogoAura == false:
#		SoundFx.play("Huhuh")
##		Dialog.DialogText.percent_visible = 0
##		Dialog.Tween.interpolate_property(
##			Dialog.DialogText, "percent_visible", 0, 1, 1,
##			Dialog.Tween.TRANS_LINEAR, Dialog.Tween.EASE_IN_OUT
##		)
#		portrait.visible = true
#		get_tree().paused = true
#		Dialog_Start()
#	else:
#		portrait.visible = false
#
#func Dialog_Start():
#	if quest_given == false:
#		ND.NPCDialog = dialog
#		get_tree().call_group("GUI_Dialog", "reset")
#		quest_given = true
#	elif quest_given == true and QM.dialogoAura == false: #QUEST ABERTA
#			ND.NPCDialog = quest_dialog
#			SaverAndLoader.custom_data.quests_saved = true
#			get_tree().call_group("GUI_Dialog", "reset")
#
## warning-ignore:unused_argument
#func _on_Area2D_body_entered(body):
#	active = true
## warning-ignore:unused_argument
#func _on_Area2D_body_exited(body):
#	active = false
