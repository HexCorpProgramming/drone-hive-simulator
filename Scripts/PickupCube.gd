extends RigidBody


var inCollider = false
var pickedUp = false
onready var playerPickup = get_node("/root/Level/PlayerDrone/Body/PlayerPickup")


#TODO: Tell, don't ask. Cube shouldn't be checking if drone is nearby.
func _ready():
	set_meta("beingPushedBy",null)
	playerPickup.connect("body_entered",self,"_on_PlayerPickup_body_entered")
	playerPickup.connect("body_exited",self,"_on_PlayerPickup_body_exited")


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_page_up") and inCollider:
		if pickedUp == false:
			print("Cube pickup triggered. (Cube is in collider and space bar has been pressed).") #debug message
			pickedUp = true
		elif pickedUp == true:
			print("Cube drop triggered.")
			pickedUp = false
			set_global_transform(get_node("../PlayerDrone/Body/CubeDropTarget").get_global_transform())
	if pickedUp == true:
		set_global_transform(get_node("../PlayerDrone/Body/CubeTarget").get_global_transform())
		gravity_scale = 0
		linear_damp = 128
	else:
		gravity_scale = 2.5
		linear_damp = 0


#TODO: If multiple cubes are close enough the drone can pick up both at the same time
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
		