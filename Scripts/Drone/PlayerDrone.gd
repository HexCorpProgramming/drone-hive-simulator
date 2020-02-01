extends Drone

#Override
func _ready():
	._ready()
	_change_ID(PlayerSettings.droneID)
	print("Debug: Player drone ready.")


#Override
func _handle_input():
	return [
	Input.is_action_pressed("ui_up"),
	Input.is_action_pressed("ui_down"),
	Input.is_action_pressed("ui_right"),
	Input.is_action_pressed("ui_left"),
	Input.is_action_just_pressed("Jump"),
	Input.is_action_just_pressed("ui_accept")
	]
	