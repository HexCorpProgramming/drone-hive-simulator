extends StaticBody
class_name Constructible

var money_cost = 0
var nanite_cost = 0
var tick_progression = 0
var completion_tick = 0 #Use this later for setting how many ticks it takes to do something.
var valid_move_ahead = false

onready var valid_move_area = get_node("ValidMoveArea")

func tick():
	print("Tick!")
	
func get_class():
	return "Constructible"
	
#This function requires an area called "ValidMoveArea" so make sure you have it or else things will not go well.
func check_if_move_is_valid():
	if valid_move_area == null:
		return false
		
	#Get the constructible in front of it.
	var target_body = null
	var bodies = valid_move_area.get_overlapping_bodies()
	for body in bodies:
		if self is body:
			target_body = body
			break
			
	#
