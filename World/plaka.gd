extends StaticBody2D


var dialog = "[img=<25>x<25>]res://Player/PlayerMissile.png[/img]"

func _ready():
	self.add_to_group("NPC")

func Dialog_Start():
	ND.NPCDialog = dialog
	get_tree().call_group("GUI_Dialog", "reset")
