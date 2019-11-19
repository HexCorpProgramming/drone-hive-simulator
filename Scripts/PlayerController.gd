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


func _physics_process(delta):
	
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


func jump():
	if Input.is_action_just_pressed("Jump") and jumpCounter > 0:
		acceleration.y = -JUMP_FORCE
		jumpCounter -= 1
	pass


func process_movement(delta):
	acceleration.y += GRAVITY * delta
	velocity.y = -acceleration.y * delta
	
	# TODO: Should be floor
	if is_on_wall():
		jumpCounter = JUMP_LIMIT
		velocity.y = 0


func limit_speed():
	if (abs(velocity.x) + abs(velocity.z)) > MAX_SPEED+0.2:
		velocity.y = 0 
		# ^ Something buggy is happening with the Y axis and needs resetting for the calculation
		# This also breaks jumping unless the vertical MAX_SPEED is slightly higher than horizontal MAX_SPEED
		# Also, if you press an X and Z movement key just once the drone keeps moving, not sure if related
		var direction = velocity.normalized()
		velocity = direction * MAX_SPEED


func handle_inputs(delta):
	set_animation()
	jump()
	update_vertical_velocity()
	update_horizontal_velocity()
	process_movement(delta)
	limit_speed()
	move_and_slide(velocity) #Applies a given vector3 to an object.


func set_animation():
	#Use: This function sets the drone's walk animation based on whether or not it has any speed.
	if $Body.frame == 0 or $Body.frame == 2:
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			$Body.playing = true
		else:
			$Body.playing = false


func update_vertical_velocity():
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Body.rotation_degrees.y = 0
		$Face.translation = Vector3(0.4, 2, 0.1)
		$Face/ID.translation = Vector3(-0.099, 0, 0)
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Body.rotation_degrees.y = 180 
		$Face.translation = Vector3(-0.4, 2, 0.1)
		$Face/ID.translation = Vector3(0.099, 0, 0)
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		velocity.x = 0
		#If left and right are pressed at the same time, the drone won't move in either direction.
	else:
		velocity.x = lerp(velocity.x,0,0.2)


func update_horizontal_velocity():
	if Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.z = SPEED
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
		#If up and down are pressed at the same time, the drone won't move in either direction.
	else:
		velocity.z = lerp(velocity.z,0,0.2)


func obey():
	#Good drone.
	pass


func good_drone():
	#Deeper and deeper.
	pass