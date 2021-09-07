extends Sprite

var quest_act: int = 0

var MainInstances = ResourceLoader0.MainInstances

func _ready():
	self.visible = false
	SaverAndLoader.connect("game_loaded", self, "_on_game_loaded")

func save_key():
	SaverAndLoader.custom_data.chaveQuest = true

func _on_game_loaded():
	save_key()

func _process(delta):
	if QM.MicaQuest == true:
		self.visible =true
