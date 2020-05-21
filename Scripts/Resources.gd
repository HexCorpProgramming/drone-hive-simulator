extends Node

var money = 0
var nanites = 0

func _ready():
	money = 100
	nanites = 100
	
func _process(delta):
	var label = get_tree().get_root().find_node("ResourcesLabel", true, false)
	if label:
		label.text = "Money: %s\nNanites: %s" % [money, nanites]