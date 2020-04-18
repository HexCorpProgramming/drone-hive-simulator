extends Node

enum STATES {WALKING, EDITING}
var current_state = STATES.WALKING 

func set_state(state):
	match state:
		0, "WALKING":
			current_state = STATES.WALKING
		1, "EDITING":
			current_state = STATES.EDITING
	handle_state_change(current_state)
	
func _ready():
	set_state("WALKING")

func get_state():
	return current_state

func handle_state_change(current_state):
	
	#Here is where we should handle everything required for a state change.
	
	print("Selected state is " + str(current_state))
	match current_state:
		0:
			print("WALKING mode active.")
			ClickSelect.set_item(null)
			SceneTools.get_playercamera().current = true
			ClickSelect.visible = false
			
		1:
			print("EDITING mode active.")
			#Set current camera
			SceneTools.get_editcamera().current = true
			#Show edit tools
			ClickSelect.visible = true
			