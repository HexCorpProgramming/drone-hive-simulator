extends InteractableObject
class_name PickupableObject

const FALLING_SPEED = 0.2
var holder = null

func _process(delta):
	
	enact_gravity()
	
	if state and holder:
		self.translation = holder.translation + Vector3(0,(holder.scale.y * 2)+3,0)
	if !state and holder:
		#TODO: cast a ray from user to 4 (or so) units ahead to avoid dropping it out of bounds.
		self.translation = holder.translation + Vector3(4,0,0) if holder.currentRotation == 1 else holder.translation + Vector3(-4,0,0)
		holder = null
	
func enact_gravity():
	var target = self.translation
	target.y - self.scale.y
	var result = get_world().direct_space_state.intersect_ray(self.translation, self.translation - Vector3(0,self.scale.y,0), [self])
	if !result:
		self.translation.y -= FALLING_SPEED

func interact(interacter = null):
	holder = interacter
	state = !state
	
	