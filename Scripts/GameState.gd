extends Node

enum STATES {WALKING, EDITING}
var selected = STATES.WALKING

func set_state(state):
	match state:
		0, "WALKING":
			selected = STATES.WALKING
		1, "EDITING":
			selected = STATES.EDITING
	handle_state_change(selected)
	
func _ready():
	set_state("WALKING")
	
func handle_state_change(selected):
	print("Selected state is " + str(selected))