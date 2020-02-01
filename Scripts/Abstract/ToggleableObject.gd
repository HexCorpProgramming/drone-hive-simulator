extends InteractableObject
class_name ToggleableObject

var isToggled = false
var beingUsedBy = null

func interact(interacter):
	isToggled = !isToggled #Flip the toggle value.
	if isToggled:
		toggle_on(interacter)
	else:
		toggle_off(interacter)
			
func toggle_on(interacter):
	beingUsedBy = interacter
	pass
	
func toggle_off(interacter):
	beingUsedBy = null
	pass