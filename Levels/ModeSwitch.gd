extends Button

signal mode_changed(new_mode)

func _on_ModeSwitch_pressed():
	if GameState.current_state == GameState.STATES.WALKING:
		GameState.current_state = GameState.STATES.EDITING
	else:
		GameState.current_state = GameState.STATES.WALKING
	emit_signal("mode_changed", GameState.current_state)
	
