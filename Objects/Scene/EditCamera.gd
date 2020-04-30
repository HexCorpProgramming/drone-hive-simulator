extends Camera

var base_camera_speed = 0.1
var camera_speed = 0.1
var increment = 0.01
var max_speed = 5

var init_translation = Vector3(0,30,0)

#X: Left and right
#Z: Up and down

func _process(delta):
	camera_speed = min(camera_speed, max_speed)
	
	if GameState.get_state() != 1: #(Edit mode)
		return
	if Input.is_action_pressed("ui_left"):
		camera_speed += increment
		translation = translation + Vector3(-camera_speed,0,0)
	elif Input.is_action_pressed("ui_right"):
		camera_speed += increment
		translation = translation + Vector3(camera_speed,0,0)
	elif Input.is_action_pressed("ui_up"):
		camera_speed += increment
		translation = translation + Vector3(0,0,-camera_speed)
	elif Input.is_action_pressed("ui_down"):
		camera_speed += increment
		translation = translation + Vector3(0,0,camera_speed)
	else:
		camera_speed = base_camera_speed
	