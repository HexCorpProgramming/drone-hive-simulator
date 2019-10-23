extends KinematicBody

var velocity = Vector3(0,FALLINGSPEED,0) #Velocity is speed in a given direction.
const SPEED = 6
const FALLINGSPEED = -6
export var droneID = "6"


func _ready():
	$Body.playing = false
	$Body.frame = 0
	get_node("Body/Face").assign_id(droneID)
	print("Debug: Player drone _ready function complete.")

func _physics_process(delta):
	
	#I just thought it'd be funny to have an "obey" function called *constantly*. These don't actually do anything.
	#It's thematically appropriate!
	obey()
	good_drone()
	
	#Actual important functions that do stuff.
	handle_inputs()

func handle_inputs():
	
	set_animation()
	update_vertical_velocity()
	update_horizontal_velocity()
	move_and_slide(velocity) #Applies a given vector3 to an object.

func set_animation():
	
	#Use: This function sets the drone's walk animation based on whether or not any keys are pressed.
	
	if any_movement_key_just_pressed() and $Body.frame == 0:
		#This makes the drone immediately start walking by skipping the first animation frame (which is them standing still).
		$Body.frame = 1
	if any_movement_key_currently_pressed():
		#If any of the directional keys are pressed, the drone will start to animate.
		$Body.playing = true
	
	else:
		if $Body.frame == 0 or $Body.frame == 2: 
			#This lets the drone "wind down" and animate until it lands on a standing frame, upon which the drone will stop animating.
			$Body.playing = false
			$Body.frame = 0

func any_movement_key_just_pressed():
	return Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")

func any_movement_key_currently_pressed():
	return Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")

func update_vertical_velocity():
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Body.rotation_degrees.y = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Body.rotation_degrees.y = 180 
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