extends InteractableObject
class_name PickupableObject

var currentUser = null
var beingUsed = false
var FALLING_SPEED = 0.2

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
	
	enact_gravity()
	
	if beingUsed and currentUser:
		self.translation = currentUser.translation + Vector3(0,(currentUser.scale.y * 2)+3,0)
	if !beingUsed and currentUser:
		#TODO: cast a ray from user to 4 units ahead to avoid dropping it out of bounds.
		self.translation = currentUser.translation + Vector3(4,0,0) if currentUser.currentRotation == 1 else currentUser.translation + Vector3(-4,0,0)
		currentUser = null
		
func enact_gravity():
	var target = self.translation
	target.y - self.scale.y
	var result = get_world().direct_space_state.intersect_ray(self.translation, self.translation - Vector3(0,self.scale.y,0), [self])
	if !result:
		self.translation.y -= FALLING_SPEED
	