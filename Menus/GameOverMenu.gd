extends CenterContainer

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_LoadButton_pressed():
	SoundFx.play("Click", 2, -10)
	Music.list_stop()
	get_tree().change_scene("res://Menus/StartMenu.tscn")


