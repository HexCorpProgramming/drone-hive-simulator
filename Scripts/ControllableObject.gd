extends KinematicBody
class_name ControllableObject

const MAX_VELOCITY = 5
const GRAVITY = 800
const DRAG_AND_FRICTION = 1.2 #TODO: Should be defined by the material/s
const AGILITY = 300
const JUMP_FORCE = GRAVITY/2
const JUMP_LIMIT = 2

var acceleration = Vector3(0,0,0) #Acceleration is the change in speed in a given direction.
var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
var jumpCounter = 0

onready var ground_ray = get_node("GroundRay")

func _ready():
	jumpCounter = JUMP_LIMIT
	print("Debug: ControllableObject _ready function complete.")


func _physics_process(delta : float):
	var input = _handle_input()
	
	#Adds arguments to array
	input.push_front(acceleration)
	input.push_back(delta)
	
	acceleration = callv("_handle_acceleration", input)
	velocity = _handle_velocity(acceleration, delta)
	_handle_animation(velocity)
	
	move_and_slide(velocity) #Applies a given Vector3 to an object.


func _handle_input():
	#Interface function
	return [false, false, false, false, false]


func _handle_animation(velocity : Vector3):
	#Interface function
	return


func _handle_acceleration(acceleration : Vector3, goNorth : bool, goSouth : bool, goEast : bool, goWest : bool, goJump : bool, delta : float):
	
	if ground_ray.is_colliding():
		acceleration.x = _update_acceleration(acceleration.x, goEast, goWest, delta)
		acceleration.x -= acceleration.x * DRAG_AND_FRICTION * delta
		acceleration.z = _update_acceleration(acceleration.z, goSouth, goNorth, delta)
		acceleration.z -= acceleration.z * DRAG_AND_FRICTION * delta
	
	acceleration = _handle_jumping(acceleration, goJump, delta)
	
	return acceleration


func _update_acceleration(accelerationAxis : int, positiveForce : bool, negativeForce : bool, delta : float):
	
	if negativeForce:
		accelerationAxis += -AGILITY
	elif positiveForce:
		accelerationAxis += AGILITY
	elif positiveForce and negativeForce:
		accelerationAxis = 0
	
	return clamp(accelerationAxis, -AGILITY, AGILITY)


func _handle_jumping(acceleration : Vector3, goJump : bool, delta : float):
	
	if ground_ray.is_colliding():
		acceleration.y = 0
		jumpCounter = JUMP_LIMIT
	else:
		acceleration.y -= GRAVITY * delta
		
	if goJump and jumpCounter > 0:
		acceleration.y = JUMP_FORCE
		jumpCounter -= 1
	
	return acceleration


func _handle_velocity(acceleration : Vector3, delta : float):
	var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
	velocity += acceleration * delta
	velocity = _clamp_vector(velocity, MAX_VELOCITY)
	return velocity


#Maths
func _clamp_vector(vector : Vector3, maxLength : float):
	var length_squared = vector.x * vector.x + vector.y * vector.y + vector.z * vector.z
	if length_squared > 0:
		if length_squared > (maxLength * maxLength):
			var length = sqrt(length_squared)
			vector *= (maxLength/length)
	return vector