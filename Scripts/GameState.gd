extends Node

enum STATES {WALKING, EDITING}
var current_state = STATES.WALKING setget set_state

func set_state(state):
	match state:
		0, "WALKING":
			current_state = STATES.WALKING
		1, "EDITING":
			current_state = STATES.EDITING
	handle_state_change()
	
func _ready():
	set_state(STATES.WALKING)


func handle_state_change():
	#Here is where we should handle everything required for a state change.
	
	print("Selected state is " + str(current_state))
	match current_state:
		STATES.WALKING:
			print("WALKING mode active.")
			ClickSelect.set_item(null, "")
			SceneTools.get_playercamera().current = true
			ClickSelect.set_visible(false)
			
		STATES.EDITING:
			print("EDITING mode active.")
			#Set current camera
			SceneTools.get_editcamera().translation = SceneTools.get_editcamera().init_translation
			SceneTools.get_editcamera().current = true
			#Show edit tools
			ClickSelect.set_visible(true)
			
