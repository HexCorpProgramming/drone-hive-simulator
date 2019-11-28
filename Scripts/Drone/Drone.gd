extends ControllableObject
class_name Drone

export var droneID = "0006"
#Has to be used on a kinematic body
var kinematicBody = self


enum Rotation {LEFT, RIGHT, FRONT, BACK}


#Override
func _ready():
	._ready()
	$Body.playing = false
	$Body.play("WalkSouth")
	$Body.frame = 0
	get_node("Face").assign_id(droneID)
	print("Debug: Drone %s _ready function complete." % droneID)


func _physics_process(delta : float):	
	#I just thought it'd be funny to have an "obey" function called *constantly*. These don't actually do anything.
	#It's thematically appropriate!
	obey()
	good_drone()
	
	var input = _handle_input()
	acceleration = _handle_acceleration(acceleration, input, delta)
	var velocity = ._handle_velocity(acceleration, delta)
	_handle_animation(acceleration)
	kinematicBody.move_and_slide(velocity)


#Override
func _handle_animation(acceleration : Vector3):
	toggle_animation_orientation(acceleration)
	toggle_animation_play(acceleration)


func toggle_animation_play(acceleration : Vector3):
	#Use: This function sets the drone's walk animation based on whether or not it has any speed.
	if $Body.frame % 2 == 0:
		if abs(acceleration.x) >= AGILITY*0.7 or abs(acceleration.z) >= AGILITY*0.7:
			$Body.playing = true
		else:
			$Body.playing = false


func toggle_animation_orientation(acceleration : Vector3):
	var direction = acceleration.normalized()
	if direction.x > 0:
		rotate_sprite(Rotation.RIGHT)
	elif direction.x < 0:
		rotate_sprite(Rotation.LEFT)
	#else:
		#Direction stays in the last position
		
	if direction.z > 0:
		$Body.play("WalkSouth")
	elif direction.z < 0:
		$Body.play("WalkNorth")
	#else:
		#Direction stays in the last position

func rotate_sprite(rotation):
	if rotation == Rotation.RIGHT:
		$Body.rotation_degrees.y = 0
		$Face.translation = Vector3(0.4, 2, 0.1)
		$Face/ID.translation = Vector3(-0.099, 0, 0)
	else:
		$Body.rotation_degrees.y = 180 
		$Face.translation = Vector3(-0.4, 2, 0.1)
		$Face/ID.translation = Vector3(0.099, 0, 0)


func _change_ID(ID : String):
	droneID = ID
	get_node("Face").assign_id(droneID)
	return true


func obey():
	#Good drone.
	pass


func good_drone():
	#Deeper and deeper.
	pass