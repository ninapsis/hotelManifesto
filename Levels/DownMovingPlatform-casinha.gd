extends Sprite

var active = false

func _ready():
	self.add_to_group("Platform")

func _process(delta):
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("avancar_dialogo"):
		$StaticBody2D/CollisionPolygon2D.disabled = true
	else:
		$StaticBody2D/CollisionPolygon2D.disabled = false
