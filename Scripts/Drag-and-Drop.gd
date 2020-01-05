extends Control

#This is the root node for the drag-and-drop UI component.
#Ideally, in drone factory, this is where drag-and-drop children would be controlled.
#i.e: "New factory component unlocked! It has been added to your menu."
#and this script would contain a script to instance a new dispenser node to allow for that, etc.

func add_button():
	var button = load("res://Objects/DragDropButton.tscn").instance()
	$PanelContainer/ScrollContainer/HBoxContainer.add_child(button)
	
func _ready():
	visible = false
