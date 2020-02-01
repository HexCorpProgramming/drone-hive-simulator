extends Spatial
class_name InteractableObject

var currentUser = null
var isToggleable = false
var isToggled = false

func _ready():
	isToggled = false

func interact(interacter):
	print("interacting with ", interacter)
	if isToggleable:
		isToggled = !isToggled
		if isToggled:
			toggle_on(interacter)
		else:
			toggle_off(interacter)
	else:
		toggle_on(interacter)
	
func toggle_on(interacter):
	print("Toggled on by ", interacter)
	currentUser = interacter

func toggle_off(interacter):
	print("Toggled off by ", interacter)
	currentUser = null
	
	