extends Area2D
var active = false
# warning-ignore-all:unused_argument
func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

# warning-ignore-all:unused_argument
func _process(delta):
	$TextureRect.visible = active

func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
