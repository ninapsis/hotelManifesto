extends Node
signal game_loaded
var custom_data = {
	missiles_unlocked = false,
	boss_defeated = false,
	questy_given = false,
	chaveQuest = false,
	NataliaQuest = false,
	quest_list  = {
		"ActiveQuests": [],
		"QuestDescription": [],
	}
}

# warning-ignore:unused_class_variable
var is_loading = false

func save_game():
	custom_data.quest_list = QM.Quests
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(custom_data))
	print(custom_data.quest_list)
	var persistingNodes = get_tree().get_nodes_in_group("Persists")
	for node in persistingNodes:
		var node_data = node.save()
		save_game.store_line(to_json(node_data))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	var persistingNodes = get_tree().get_nodes_in_group("Persists")
	for node in persistingNodes:
		node.queue_free()
	
	save_game.open("user://savegame.save", File.READ)
	
	
	if not save_game.eof_reached():
		custom_data = parse_json(save_game.get_line()) 
	
	while not save_game.eof_reached():
		var line_string = save_game.get_line()
		if line_string != "":
			var current_line = parse_json(line_string)
			if current_line != null:
				var newNode = load(current_line["filename"]).instance()
				get_node(current_line["parent"]).add_child(newNode, true)
				newNode.position = Vector2(current_line["position_x"], current_line["position_y"])
				for property in current_line.keys():
					if (property == "filename"
					or property == "parent"
					or property == "position_x"
					or property == "position_y"):
						continue
					newNode.set(property, current_line[property])
	save_game.close()
	QM.Quests = custom_data.quest_list
	emit_signal("game_loaded")
