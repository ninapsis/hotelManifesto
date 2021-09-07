extends StaticBody2D

func _ready():
	self.add_to_group("Platform")

func _process(delta):
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("avancar_dialogo"):
		$CollisionShape2D.disabled = true

	else:
		$CollisionShape2D.disabled = false


