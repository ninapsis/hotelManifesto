extends Control
var quest_act: int = 0

var MainInstances = ResourceLoader0.MainInstances

func _ready():
	$QuestList.set_allow_reselect(true)
	add_quest()
	self.visible = false
	SaverAndLoader.connect("game_loaded", self, "_on_game_loaded")

func add_quest():
	SaverAndLoader.custom_data.questy_given = true
#	SaverAndLoader.custom_data.quest_list = true
	if quest_act < QM.Quests.ActiveQuests.size():
		$QuestList.add_item(QM.Quests.ActiveQuests[quest_act])
		quest_act += 1
	else:
		return
func _on_game_loaded():
	add_quest()

func remove_quest(quest, quest_des):
	if quest in QM.Quests.ActiveQuests:
		var removed_quest = QM.Quests.ActiveQuests.find(quest)
		$QuestList.remove_item(removed_quest)
		QM.Quests.ActiveQuests.erase(quest)
		QM.Quests.QuestDescription.erase(quest_des)
		$QuestDescription.text = ""
		quest_act -= 1
#TESTE
#func save_game():
#	var save_game = File.new()
#	save_game.open("user://savegame.save", File.WRITE)
#	var save_nodes = get_tree().get_nodes_in_group("Persists")
#	for node in save_nodes:
#		# Check the node is an instanced scene so it can be instanced again during load.
#		if node.filename.empty():
#			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
#			continue
#
#		# Check the node has a save function.
#		if !node.has_method("save"):
#			print("persistent node '%s' is missing a save() function, skipped" % node.name)
#			continue
#
#		# Call the node's save function.
#		var node_data = node.call("save")
#
#		# Store the save dictionary as a new line in the save file.
#		save_game.store_line(to_json(node_data))
#	save_game.close()
#
#func save():
#	var save_dictionary = {
#		"filename" : get_filename(),
#		"parent" : get_parent().get_path(),
#	}
#	return save_dictionary
##TESTE END

func _on_QuestList_item_selected(index):
	$QuestDescription.text = QM.Quests.QuestDescription[index]

func _on_Button_pressed():
	self.visible = false
