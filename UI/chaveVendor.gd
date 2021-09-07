extends Sprite

func _ready():
	self.visible = false

func _process(_delta):
	if QM.vendorQuest == true:
		self.visible =true
