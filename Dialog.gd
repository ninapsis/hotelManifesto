extends Control

var dialog = ["a"]
var page = 0

var paused = false setget set_paused

onready var Tween = $Tween
onready var DialogText = $DialogText
onready var DialogBG = $TextureRect

func set_paused(value):
	paused = value
	get_tree().paused = paused

func _ready():
	$portrait_liro.visible = false
	DialogText.visible = false
	DialogBG.visible = false
	add_to_group("GUI_Dialog")
	DialogText.bbcode_text = dialog[page]

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if page < dialog.size() - 1:
			SoundFx.play("Click", rand_range(0.6, 1.2), -10)
			page += 1
			DialogText.bbcode_text = dialog[page]
			DialogText.percent_visible = 0
			$Tween.interpolate_property(
				$DialogText, "percent_visible", 0, 1, 1, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
			$Tween.start()
		else:
			DialogText.visible = false
			DialogBG.visible = false
			self.paused = paused
	if Input.is_action_just_pressed("pause"):
		DialogText.visible = false
		DialogBG.visible = false


func reset():
	dialog = ND.NPCDialog
	page = 0
	DialogText.visible = true
	DialogBG.visible = true
	DialogText.bbcode_text = dialog[page]
