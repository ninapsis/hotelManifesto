extends StaticBody2D

func _ready():
	self.add_to_group("Platform")
# warning-ignore-all:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("avancar_dialogo"):
		$CollisionShape2D.disabled = true
		$CollisionShape2D3.disabled = true
		$CollisionShape2D4.disabled = true
		$CollisionShape2D2.disabled = true
		$CollisionShape2D5.disabled = true
		$CollisionShape2D6.disabled = true
	else:
		$CollisionShape2D.disabled = false
		$CollisionShape2D3.disabled = false
		$CollisionShape2D4.disabled = false
		$CollisionShape2D2.disabled = false
		$CollisionShape2D5.disabled = false
		$CollisionShape2D6.disabled = false

