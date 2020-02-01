extends Spatial
class_name ControllableObject

const MAX_VELOCITY = 5 #TODO: Max velocity doesn't work properly over 6
const GRAVITY = 1000
const DRAG_AND_FRICTION = 4 #TODO: Should be defined by the material/s
const AGILITY = 400
const JUMP_FORCE = GRAVITY/2
const JUMP_LIMIT = 2

var acceleration = Vector3(0,0,0) #Acceleration is the change in speed in a given direction.
var jumpCounter = 0

onready var ground_ray = get_node("GroundRay")


func _handle_input() -> Array:
	#Interface function
	return [false, false, false, false, false, false]
	#North, south, east, west, jump, interact.


func _handle_animation(velocity : Vector3) -> void:
	#Interface function
	return

func _handle_acceleration(acceleration : Vector3, input : Array, time : float) -> Vector3:
	
	if ground_ray.is_colliding():
		acceleration.x = _update_acceleration(acceleration.x, input[2], input[3])
		acceleration.x -= acceleration.x * DRAG_AND_FRICTION * time
		acceleration.y = 0
		acceleration.z = _update_acceleration(acceleration.z, input[1], input[0])
		acceleration.z -= acceleration.z * DRAG_AND_FRICTION * time
	else:
		acceleration.y -= GRAVITY * time * 2
	
	acceleration.y = _handle_jumping(acceleration.y, input[4])
	
	return acceleration


func _update_acceleration(accelerationAxis : int, positiveForce : bool, negativeForce : bool) -> float:
	
	if negativeForce:
		accelerationAxis += -AGILITY
	elif positiveForce:
		accelerationAxis += AGILITY
	elif positiveForce and negativeForce:
		accelerationAxis = 0
	
	return clamp(accelerationAxis, -AGILITY, AGILITY)


func _handle_jumping(upwardsAcceleration : float, goJump : bool) -> float:
	
	if ground_ray.is_colliding():
		jumpCounter = JUMP_LIMIT
		
	if goJump and jumpCounter > 0:
		upwardsAcceleration = JUMP_FORCE
		jumpCounter -= 1
	
	return upwardsAcceleration


func _handle_velocity(acceleration : Vector3, time : float) -> Vector3:
	var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
	velocity += acceleration * time
	return _clamp_vector(velocity, MAX_VELOCITY)


#Maths, will be incorporated in Godot 4.0
func _clamp_vector(vector : Vector3, maxLength : float) -> Vector3:
	var length_squared = vector.x * vector.x + vector.y * vector.y + vector.z * vector.z
	if length_squared > 0:
		if length_squared > (maxLength * maxLength):
			var length = sqrt(length_squared)
			vector *= (maxLength/length)
	return vector


func _clamp_axis(vectorAxis : float, maxLength : float) -> float:
	var length_squared = vectorAxis * vectorAxis
	if length_squared > 0:
		if length_squared > (maxLength * maxLength):
			var length = sqrt(length_squared)
			vectorAxis *= (maxLength/length)
	return vectorAxis