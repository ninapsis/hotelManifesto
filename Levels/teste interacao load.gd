extends Area2D
var active = false

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


func _process(_delta):
	$cuore.visible = active

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		active = true


func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		active = false
