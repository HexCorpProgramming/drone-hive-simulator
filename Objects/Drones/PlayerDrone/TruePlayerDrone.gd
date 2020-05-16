extends Drone

#A reminder that a PlayerDrone has these member variables:
#drone_id, emotional_intelligence, productivity, innovative, charge

#These components:
#face, emotion, digits, digit1, digit2, digit3, digit4

#Gravity:
#gravity = Vector3(0,-7,0)

#And the functions:
#toggle_display() and set_drone_id(id)

var movement = Vector3(0,0,0)
export var movement_speed = 400
export var animation_speed = 5
var is_moving = false
var moving_right = true
var moving_up = false
var direction = null

onready var body = $Body

func _ready():
	
	for animation in body.frames.get_animation_names():
		body.frames.set_animation_speed(animation, animation_speed)
	
	print("PlayerDrone ready.")
	toggle_display()
	
func _process(delta):
	
	movement = _get_inputs()
	_handle_animation()
	move_and_slide(movement * delta)

	
func _get_inputs():
	
	var new_movement = Vector3(0,0,0)
	
	moving_up = false
	moving_right = false
	
	if Input.is_action_pressed("ui_up"):
		moving_up = true
		direction = "UP"
		new_movement += Vector3(0,0,-1)
	if Input.is_action_pressed("ui_down"):
		moving_up = false
		direction = "DOWN"
		new_movement += Vector3(0,0,1)
	if Input.is_action_pressed("ui_left"):
		direction = "LEFT"
		new_movement += Vector3(-1,0,0)
	if Input.is_action_pressed("ui_right"):
		direction = "RIGHT"
		new_movement += Vector3(1,0,0)
		
	if new_movement == Vector3(0,0,0):
		#Interpolate instead of returning nothing.
		is_moving = false
		return lerp(movement, Vector3(0,0,0), 0.2)
		
	is_moving = true
	return new_movement.normalized() * movement_speed
	
func _handle_animation():
	if is_moving:
		body.playing = true
	elif not is_moving and body.frame == 0 or body.frame == 2:
		#Only stop animating when the drone is at a standstill frame.
		body.playing = false
		body.frame = 0
	
	if direction == "RIGHT":
		body.animation = "WalkRight"
		face.visible = true
		body.rotation_degrees.y = 0
		face.translation = Vector3(0.4, 2, 0.1)
		digits.translation = Vector3(-0.099, 0, 0)
	elif direction == "UP":
		body.animation = "WalkUp"
		face.visible = false
	elif direction == "LEFT":
		body.rotation_degrees.y = 180 
		face.translation = Vector3(-0.4, 2, 0.1)
		digits.translation = Vector3(0.099, 0, 0)
	elif direction == "DOWN":
		body.animation = "WalkRight"
		face.visible = true
