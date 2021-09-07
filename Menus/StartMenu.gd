extends CanvasLayer

onready var startButton = $CenterContainer/VBoxContainer/StartButton
onready var loadButton = $CenterContainer/VBoxContainer/LoadButton
onready var quitButton = $CenterContainer/VBoxContainer/QuitButton
onready var coisas = $CenterContainer/Coisas

func _ready():
	OS.window_fullscreen = true
	VisualServer.set_default_clear_color(Color.black)
	coisas.visible = false
#	SoundFx.play("mainmenuhum")
# warning-ignore:unused_argument
func _on_StartButton_pressed():
	SoundFx.play("Click", 1, -10)
	get_tree().change_scene("res://UI/cutscene1.tscn")

# warning-ignore-all:unused_argument
func _on_LoadButton_pressed():
	SoundFx.play("Click", 2, -10)
	SaverAndLoader.is_loading = true
	get_tree().change_scene("res://World.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_Instructions_pressed():
	SoundFx.play("Click", rand_range(0.6, 1.2), -10)
	startButton.visible = false
	loadButton.visible = false
	quitButton.visible = false
	coisas.visible = true

# warning-ignore:unused_argument
func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Menus/StartMenu.tscn")
