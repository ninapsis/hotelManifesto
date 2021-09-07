extends StaticBody2D

var dialog = ["Essa porta o levará para outra área. Para abrir, aperte a tecla E."]
var active = false

func _process(delta):
	if active:
		Dialog_Start()
#func _process(delta):
#	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("avancar_dialogo"):
#		$KinematicBody2D/vassoura.disabled = true
#	else:
#		$KinematicBody2D/vassoura.disabled = false

func esconder():
	hide()

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
	esconder()
