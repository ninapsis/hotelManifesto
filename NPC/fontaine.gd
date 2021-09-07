extends StaticBody2D
#var MainInstances = ResourceLoader.MainInstances

onready var portrait = $CanvasLayer/cuore
onready var portrait_face = $CanvasLayer/cuore2

var dialog = ["[color=#FFCD00]A guy on a huge, cozy looking hoodie - He is eating some chips[/color]\nYour suit looks great! This place is a bit windy, so it's nice to be covered.",
"[color=#FFCD00]A guy on a huge, cozy looking hoodie - He is eating some chips[/color]\nOn really cold days I like to weat two pairs of socks. But to be honest, none of my socks pairs are actually paired.",
"[color=#FFCD00]A guy on a huge, cozy looking hoodie - He offers you some chips. You take some.[/color]\nYou don't talk much, right? I'm cool with that. Call me Icaro.",
"[color=#FFCD00]Icaro - You are both eating some chips[/color]\nBy the way, in case you never saw those [shake rate=5 level=10]shadowy[/shake]... people? Ghosts? I dunno.",
"[color=#FFCD00]Icaro - You are both eating some chips[/color]\nThey won't hurt you as long as you don't touch them. That kinda makes sense, I guess.",
"[color=#FFCD00]Icaro - You are both eating some chips[/color]\nWell, I'm gonna stay around here in case you want some company. Or chips!"]

var quest_dialog = ["[color=#FFCD00]Icaro - You share some chips silently, enjoying the cold breeze.[/color]"]
#var comp_dialog = ["Thank you! I will breathe better now. Thanks!"]
#
var quest_given: bool = false
#var quest_name: String = "Kill the worms"
#var quest_des: String = "Your friend is scared of worms and won't move unless you kill them all."

var active = false

func _ready():
	portrait.visible = false
	portrait_face.visible = false
	self.add_to_group("NPC")

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("conversar") and active and QM.dialogoFontaine == false:
		SoundFx.play("Bub")
		portrait.visible = true
		get_tree().paused = true
		Dialog_Start()
	else:
		portrait.visible = false
		portrait_face.visible = false


func Dialog_Start():
	if quest_given == false: #DANDO QUEST
		ND.NPCDialog = dialog
		get_tree().call_group("GUI_Dialog", "reset")
		get_tree().call_group("Quest", "add_quest")
		quest_given = true

	elif quest_given == true and QM.dialogoFontaine == false: #QUEST ABERTA
			ND.NPCDialog = quest_dialog
			SaverAndLoader.custom_data.quest_given = true
			get_tree().call_group("GUI_Dialog", "reset")
#
#	elif quest_given == true and QM.dialogoFontaine == true: #QUEST CONCLUIDA
#		ND.NPCDialog = quest_dialog
#		portrait.visible=false
#		portrait_face.visible=true
#		get_tree().call_group("GUI_Dialog", "reset")
#		get_tree().call_group("Quest", "remove_quest", quest_name, quest_des)

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	active = true
# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	active = false
