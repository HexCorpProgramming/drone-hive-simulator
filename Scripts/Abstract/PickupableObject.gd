extends InteractableObject
class_name PickupableObject

var beingUsed = false

func interact(interacter):
	currentUser = interacter
	print("I am being interacted with!")
	print("I am being interacted by " + str(currentUser))
	beingUsed = !beingUsed
	if beingUsed:
		print("Okay, let's interact with one another!")
	else:
		print("Okay, time to stop interacting with you!")


func _process(delta):
	if beingUsed and currentUser:
		self.translation = currentUser.translation + Vector3(0,(currentUser.scale.y * 2)+3,0)
	if !beingUsed and currentUser:
		self.translation = currentUser.translation + Vector3(4,0,0)
		currentUser = null