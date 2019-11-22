extends KinematicBody
class_name ControllableObject

const MAX_VELOCITY = 5
const GRAVITY = 800
const DRAG_AND_FRICTION = 1.2 #TODO: Should be defined by the material/s
const AGILITY = 300
const JUMP_FORCE = GRAVITY/2
const JUMP_LIMIT = 2

var acceleration = Vector3(0,0,0) #Acceleration is the change in speed in a given direction.
var jumpCounter = 0

onready var ground_ray = get_node("GroundRay")

func _ready():
	jumpCounter = JUMP_LIMIT
	print("Debug: ControllableObject _ready function complete.")


func _physics_process(delta : float):
	acceleration = _generate_acceleration(delta)
	var velocity = _generate_velocity(acceleration, delta)
	
	_handle_animation(velocity)
	
	move_and_slide(velocity) #Applies a given Vector3 to an object.


func _handle_animation(velocity : Vector3):
	#Interface function
	return


func _generate_acceleration(delta : float):
	
	var go_north = Input.is_action_pressed("ui_up")
	var go_south = Input.is_action_pressed("ui_down")
	var go_west = Input.is_action_pressed("ui_left")
	var go_east = Input.is_action_pressed("ui_right")
	
	if ground_ray.is_colliding():
		acceleration.x = _update_acceleration(acceleration.x, go_east, go_west, delta)
		acceleration.x -= acceleration.x * DRAG_AND_FRICTION * delta
		acceleration.z = _update_acceleration(acceleration.z, go_south, go_north, delta)
		acceleration.z -= acceleration.z * DRAG_AND_FRICTION * delta
	
	acceleration = _handle_jumping(acceleration, delta)
	
	return acceleration


func _update_acceleration(accelerationAxis : int, positiveForce : bool, negativeForce : bool, delta : float):
	
	if negativeForce:
		accelerationAxis += -AGILITY
	elif positiveForce:
		accelerationAxis += AGILITY
	elif positiveForce and negativeForce:
		accelerationAxis = 0
	
	return clamp(accelerationAxis, -AGILITY, AGILITY)


func _handle_jumping(acceleration : Vector3, delta : float):
	if ground_ray.is_colliding():
		acceleration.y = 0
		if Input.is_action_just_pressed("Jump"):
			acceleration.y = JUMP_FORCE
	else:
		acceleration.y -= GRAVITY * delta
	
	return acceleration


func _generate_velocity(acceleration : Vector3, delta : float):
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