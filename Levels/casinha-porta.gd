extends Sprite
var active = false

# warning-ignore-all:unused_argument
func _ready():
	$TextureRect.visible = false

func _process(delta):
	if Input.is_action_pressed("conversar") and active == true:
		$TextureRect.visible = true
	if active == false:
		$TextureRect.visible = false

func _on_Area2D_body_entered(body):
	active = true

func _on_Area2D_body_exited(body):
	active = false
	
