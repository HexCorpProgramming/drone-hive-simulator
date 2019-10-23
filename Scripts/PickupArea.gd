extends Area

signal test1
export var thingToSend = "hello"

func _ready():
	pass
func _process(delta):
	if Input.is_action_just_pressed("secret_cube_button"):
		emit_signal("test1")
		print("test1 signal emitted.")