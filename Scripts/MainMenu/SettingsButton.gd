extends Button

onready var dronename = get_node("../NameBox")

func _on_Button_pressed():
	get_tree().change_scene("res://Levels/Box.tscn")
	if !dronename.text.empty():
		PlayerSettings.change_id(dronename.text)
	else:
		PlayerSettings.change_id(PlayerSettings.randomize_id())