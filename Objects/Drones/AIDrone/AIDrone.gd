extends ControllableDrone

#Override
func _ready():
	._ready()
	._change_ID("5890")
	print("Debug: AI drone ready.")


#Override
func _handle_input():
	var goNorth = false
	var goSouth = true
	var goEast = true
	var goWest = false
	var goJump = false
	var interact = false
	
	return [goNorth, goSouth, goEast, goWest, goJump, interact]