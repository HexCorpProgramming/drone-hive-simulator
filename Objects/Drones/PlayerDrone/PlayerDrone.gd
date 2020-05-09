extends ControllableDrone

#Override
func _ready():
	._ready()
	_change_ID(PlayerSettings.droneID)
	print("Debug: Player drone ready.")


#Override
func _handle_input():
	if GameState.get_state() != 0: #(Walking state)
		return[false,false,false,false,false,false]
	return [
	Input.is_action_pressed("ui_up"),
	Input.is_action_pressed("ui_down"),
	Input.is_action_pressed("ui_right"),
	Input.is_action_pressed("ui_left"),
	Input.is_action_just_pressed("ui_jump"),
	Input.is_action_just_pressed("ui_accept")
	]
	