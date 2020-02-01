extends Spatial
class_name InteractableObject

var currentUser = null
var toggleable = true

func interact(interacter):
	print("interacting with ", interacter)