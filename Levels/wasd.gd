extends Area2D
var active = false

var MainInstances = ResourceLoader0.MainInstances
onready var animationPlayer = $AnimationPlayerr
# warning-ignore-all:unused_argument
func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

# warning-ignore-all:unused_argument
func _process(_delta):
	$wasdd.visible = active

func _on_NPC_body_entered(body):
	if body.is_in_group("Player"):
		active = true


func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		active = false
