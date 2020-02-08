extends Button

func _ready():
	connect("pressed", self, "_on_pressed")
	pause_mode = PAUSE_MODE_PROCESS

func _on_pressed():
	print("Going back to main menu...")
	get_tree().change_scene("res://Levels/MenuMain.tscn")
	get_tree().paused = false