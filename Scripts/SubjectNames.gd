extends Node

var names = ["Hex","Remi","Sonic the Hedgehog","Aiden Claus","May Den","Garfield","Jon Arbuckle"]

func get_name():
	return names[randi() % names.size()]