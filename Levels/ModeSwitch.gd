extends Button

func _on_ModeSwitch_pressed():
	if GameState.current_state == GameState.STATES.WALKING:
		GameState.current_state = GameState.STATES.EDITING
	else:
		GameState.current_state = GameState.STATES.WALKING
