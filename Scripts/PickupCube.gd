extends RigidBody

var inCollider = false
var pickedUp = false

func _process(delta):
	var dropPlayer = get_node("../SceneControl/SFXDrop")
	var pickupPlayer = get_node("../SceneControl/SFXPickup")
	
	if Input.is_action_just_pressed("ui_accept") && inCollider:
		if pickedUp:
			print("Cube drop triggered.")
			pickedUp = false
			dropPlayer.play()
			set_global_transform(get_node("../PlayerDrone/Body/CubeDropTarget").get_global_transform())			
		else:
			print("Cube pickup triggered. (Cube is in collider and space bar has been pressed).") #debug message
			pickedUp = true
			pickupPlayer.play()
			
	if pickedUp:
		set_global_transform(get_node("../PlayerDrone/Body/CubeTarget").get_global_transform())
		gravity_scale = 0
		linear_damp = 128
	else:
		gravity_scale = 2.5
		linear_damp = 0



func _on_PlayerPickup_body_entered(body):
	if body.get_name() == get_name():
		print("Cube has entered player pickup collision.")
		$OmniLight.light_energy = 1
		inCollider = true


func _on_PlayerPickup_body_exited(body):
	if body.get_name() == get_name():
		print("Cube has left player pickup collision.")
		$OmniLight.light_energy = 0
		inCollider = false
	