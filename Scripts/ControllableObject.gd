extends KinematicBody
class_name ControllableObject

var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
var acceleration = Vector3(0,0,0) #Acceleration is the change in speed in a given direction.
var jumpCounter = 0
const SPEED = 6
const MAX_SPEED = 4.8
const GRAVITY = 981
const JUMP_FORCE = GRAVITY/2
const JUMP_LIMIT = 2


func _ready():
	jumpCounter = JUMP_LIMIT
	print("Debug: ControllableObject _ready function complete.")


func _physics_process(delta : float):
	velocity = handle_inputs(delta)
	handle_animation(velocity)
	
	print(jumpCounter)
	print(velocity.x)
	print(velocity.y)
	print(velocity.z)
	
	move_and_slide(velocity) #Applies a given Vector3 to an object.


func handle_animation(velocity : Vector3):
	#Interface function
	return


func handle_inputs(delta : float):
	jump()
	velocity.z = update_velocity_axis(velocity.z,"ui_up","ui_down")
	velocity.x = update_velocity_axis(velocity.x,"ui_left","ui_right")
	return process_movement(delta, velocity)


func jump():
	if Input.is_action_just_pressed("Jump") and jumpCounter > 0:
		acceleration.y = -JUMP_FORCE
		jumpCounter -= 1
	pass


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
	if (abs(velocity.x) + abs(velocity.z)) > MAX_SPEED:
		var direction = velocity.normalized()
		velocity = direction * MAX_SPEED
		
	return velocity