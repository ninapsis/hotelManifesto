extends Sprite
var MainInstances = ResourceLoader0.MainInstances
func _ready():
	self.visible = false



func _process(delta):
	if QM.chaveQuest == true:
		self.visible = true
	if QM.vendorQuest == true:
		self.visible = false
