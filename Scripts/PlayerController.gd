extends KinematicBody

var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
var acceleration = Vector3(0,0,0) #Acceleration is the change in speed in a given direction.
var jumpCounter = 0
const SPEED = 6
const MAX_SPEED = 4.8
const GRAVITY = 981
const JUMP_FORCE = GRAVITY/2
const JUMP_LIMIT = 2
export var droneID = "6"


func _ready():
	$Body.playing = false
	$Body.frame = 0
	get_node("Face").assign_id(droneID)
	jumpCounter = JUMP_LIMIT
	print("Debug: Player drone _ready function complete.")


func _physics_process(delta : float):
	#Actual important functions that do stuff.
	handle_inputs(delta)
	
	print(jumpCounter)
	print(velocity.x)
	print(velocity.y)
	print(velocity.z)
	print($Body.frame)
	
	#I just thought it'd be funny to have an "obey" function called *constantly*. These don't actually do anything.
	#It's thematically appropriate!
	obey()
	good_drone()


func handle_inputs(delta : float):
	set_animation(velocity)
	jump()
	velocity.z = update_velocity_axis(velocity.z,"ui_up","ui_down")
	velocity.x = update_velocity_axis(velocity.x,"ui_left","ui_right")
	velocity = process_movement(delta, velocity)
	move_and_slide(velocity) #Applies a given vector3 to an object.


func jump():
	if Input.is_action_just_pressed("Jump") and jumpCounter > 0:
		acceleration.y = -JUMP_FORCE
		jumpCounter -= 1
	pass


func process_movement(delta : float, velocity : Vector3):

	velocity = process_jump(delta, velocity)
	velocity = limit_speed(velocity)
	
	return velocity
	


func process_jump(delta : float, velocity : Vector3):
	acceleration.y += GRAVITY * delta
	velocity.y = -acceleration.y * delta
	
	# TODO: Should be floor
	if is_on_wall():
		jumpCounter = JUMP_LIMIT
		velocity.y = 0
		
	return velocity


func limit_speed(velocity : Vector3):
	if (abs(velocity.x) + abs(velocity.z)) > MAX_SPEED+0.2:
		velocity.y = 0 
		# ^ Something buggy is happening with the Y axis and needs resetting for the calculation
		# This also breaks jumping unless the vertical MAX_SPEED is slightly higher than horizontal MAX_SPEED
		# Also, if you press an X and Z movement key just once the drone keeps moving, not sure if related
		# Turns out if the drone jumps and does the above it stays at that height without falling
		var direction = velocity.normalized()
		velocity = direction * MAX_SPEED
		
	return velocity


func set_animation(velocity : Vector3):
	toggle_animation_orientation(velocity)
	toggle_animation_play(velocity)


func toggle_animation_play(velocity : Vector3):
	#Use: This function sets the drone's walk animation based on whether or not it has any speed.
	if $Body.frame == 0 or $Body.frame == 2:
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			$Body.playing = true
		else:
			$Body.playing = false


func toggle_animation_orientation(velocity : Vector3):
	var direction = velocity.normalized()
	
	if direction.x > 0:
		$Body.rotation_degrees.y = 0
		$Face.translation = Vector3(0.4, 2, 0.1)
		$Face/ID.translation = Vector3(-0.099, 0, 0)
	else:
		$Body.rotation_degrees.y = 180 
		$Face.translation = Vector3(-0.4, 2, 0.1)
		$Face/ID.translation = Vector3(0.099, 0, 0)


func update_velocity_axis(velocityAxis : float, positiveMovementCommand : String, negativeMovementCommand : String):
	if Input.is_action_pressed(positiveMovementCommand):
		velocityAxis = -SPEED
	if Input.is_action_pressed(negativeMovementCommand):
		velocityAxis = SPEED
	if Input.is_action_pressed(positiveMovementCommand) and Input.is_action_pressed(negativeMovementCommand):
		velocityAxis = 0
		#If positiveMovementCommand and negativeMovementCommand are pressed at the same time, the drone won't move in either direction.
	else:
		velocityAxis = lerp(velocityAxis,0,0.2)
	
	return velocityAxis


func obey():
	#Good drone.
	pass


func good_drone():
	#Deeper and deeper.
	pass