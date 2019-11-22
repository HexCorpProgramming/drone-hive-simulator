extends KinematicBody
class_name ControllableObject

const MAX_VELOCITY = 5
const GRAVITY = 800
const DRAG_AND_FRICTION = 0.2 #TODO: Should be defined by the material/s
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
	
	var direction = generate_direction()
	#acceleration = generate_acceleration(direction, delta)
	var velocity = generate_velocity(direction, delta)
	
	handle_animation(velocity)
	
	print(acceleration)
	print(velocity)
	print(direction)
	
	move_and_slide(velocity) #Applies a given Vector3 to an object.


func handle_animation(velocity : Vector3):
	#Interface function
	return


func generate_direction():
	var direction = Vector3(0,0,0) #Direction of movement
	
	var go_north = Input.is_action_pressed("ui_up")
	var go_south = Input.is_action_pressed("ui_down")
	var go_west = Input.is_action_pressed("ui_left")
	var go_east = Input.is_action_pressed("ui_right")
	
	direction.z = _updateAxisDirection(direction.z, go_south, go_north)
	direction.x = _updateAxisDirection(direction.x, go_east, go_west)	
		
	return direction.normalized()


func _updateAxisDirection(directionAxis : int, positiveDirection : bool, negativeDirection : bool):
	
	if negativeDirection:
		directionAxis += -1
	elif positiveDirection:
		directionAxis += 1
	elif positiveDirection and negativeDirection:
		directionAxis = 0
		
	return directionAxis


func generate_acceleration(direction : Vector3, delta : float):
	
	if ground_ray.is_colliding():
		acceleration = direction * AGILITY
			
	acceleration.x -= DRAG_AND_FRICTION * delta
	acceleration.z -= DRAG_AND_FRICTION * delta
	
	return acceleration


func _handleJumping(acceleration : Vector3, delta : float):
	if ground_ray.is_colliding():
		acceleration.y = 0
		if Input.is_action_just_pressed("Jump"):
			acceleration.y = JUMP_FORCE
	else:
		acceleration.y -= GRAVITY * delta
	
	return acceleration


func generate_velocity(direction : Vector3, delta : float):
	var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
	
	if direction.is_normalized():
		velocity = direction * MAX_VELOCITY
	
	acceleration = _handleJumping(acceleration, delta)

	velocity.y += acceleration.y * delta
	return velocity