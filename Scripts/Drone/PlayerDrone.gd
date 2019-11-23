extends Drone

#Override
func _ready():
	._ready()
	._change_ID("1211")
	print("Debug: Player drone ready.")


#Override
func _handle_input():
	var goNorth = Input.is_action_pressed("ui_up")
	var goSouth = Input.is_action_pressed("ui_down")
	var goEast = Input.is_action_pressed("ui_right")
	var goWest = Input.is_action_pressed("ui_left")
	var goJump = Input.is_action_just_pressed("Jump")
	
	return [goNorth, goSouth, goEast, goWest, goJump]