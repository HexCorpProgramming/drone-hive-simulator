extends Node

var money = 0
var nanites = 0
var label = null

onready var purchase = load("res://Objects/Particles/Purchase.tscn")

func _ready():
	money = 100
	nanites = 100
	
func _process(delta):
	
	label = get_tree().get_root().find_node("ResourcesLabel", true, false)
	if label:
		label.text = "Money: %s      Nanites: %s" % [money, nanites]
		
func handle_particles():
	if label:
		print("Adding particle")
		var particle = purchase.instance()
		label.add_child(particle)
		