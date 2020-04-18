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
	
	#Here is where we should handle everything required for a state change.
	
	print("Selected state is " + str(selected))
	match selected:
		0:
			print("WALKING mode active.")
			ClickSelect.set_item(null)
			SceneTools.get_playercamera().current = true
			
		1:
			print("EDITING mode active.")
			SceneTools.get_editcamera().current = true
			