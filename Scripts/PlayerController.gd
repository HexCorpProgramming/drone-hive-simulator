extends ControllableObject

export var droneID = "6"


#Override
func _ready():
	._ready()
	$Body.playing = false
	$Body.frame = 0
	get_node("Face").assign_id(droneID)
	print("Debug: Player drone _ready function complete.")


#Override
func _physics_process(delta : float):
	._physics_process(delta)
	
	#I just thought it'd be funny to have an "obey" function called *constantly*. These don't actually do anything.
	#It's thematically appropriate!
	obey()
	good_drone()


#Override
func handle_animation(velocity : Vector3):
	.handle_animation(velocity)
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


func obey():
	#Good drone.
	pass


func good_drone():
	#Deeper and deeper.
	pass