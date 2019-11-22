extends KinematicBody
class_name ControllableObject

var velocity = Vector3(0,0,0) #Velocity is speed in a given direction.
var acceleration = Vector3(0,0,0) #Acceleration is the change in speed in a given direction.
var jumpCounter = 0
const SPEED = 6
const MAX_SPEED = 4.8
const GRAVITY = 800
const JUMP_FORCE = GRAVITY/2
const JUMP_LIMIT = 2

onready var ground_ray = get_node("GroundRay")

func _ready():
	jumpCounter = JUMP_LIMIT
	print("Debug: ControllableObject _ready function complete.")


func _physics_process(delta : float):
	
	velocity = generate_velocity(generate_direction(), delta)
	
	handle_animation(velocity)
	
	print(velocity)
	print(velocity.normalized())
	#print(acceleration)
	
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


func generate_velocity(direction : Vector3, delta : float):
	var velocity = Vector3(0,0,0)
	
	if direction.is_normalized():
		velocity = direction * MAX_SPEED
			
	if Input.is_action_just_pressed("Jump") and ground_ray.is_colliding():
		acceleration.y = JUMP_FORCE

	acceleration.y -= GRAVITY * delta
	
	velocity.y += acceleration.y * delta
	return velocity