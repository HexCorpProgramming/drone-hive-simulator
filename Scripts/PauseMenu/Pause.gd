extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	visible = false
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused = !get_tree().paused
		visible = !visible