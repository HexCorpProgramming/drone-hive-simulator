extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		visible = !visible
