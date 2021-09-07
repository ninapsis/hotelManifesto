extends StaticBody2D

func _ready():
	self.add_to_group("Platform")
# warning-ignore-all:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("avancar_dialogo"):
		$colider.disabled = true
	else:
		$colider.disabled = false

