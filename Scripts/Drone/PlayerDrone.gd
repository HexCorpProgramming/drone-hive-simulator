extends Drone

var inventory = null

#Override
func _ready():
	._ready()
	_change_ID(PlayerSettings.droneID)
	print("Debug: Player drone ready.")


#Override
func _handle_input():
	var goNorth = Input.is_action_pressed("ui_up")
	var goSouth = Input.is_action_pressed("ui_down")
	var goEast = Input.is_action_pressed("ui_right")
	var goWest = Input.is_action_pressed("ui_left")
	var goJump = Input.is_action_just_pressed("Jump")
	
	return [goNorth, goSouth, goEast, goWest, goJump]
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if inventory:
			print("Dropping my item like a good drone!")
			inventory.interact(self)
			inventory = null
		else:
			print("Beep boop. This drone is casting a ray!")
			var foundObject = $InteractionRay.get_collider()
			if foundObject and foundObject.has_method("interact"):
				print("Hey you, ", foundObject, " interact with me!")
				foundObject.interact(self)
				inventory = foundObject
			else:
				print("I didn't find anything!")
			
			