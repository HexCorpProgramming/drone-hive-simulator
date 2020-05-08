extends KinematicBody

func _ready():
	#print("I'm a subject and I sure do hope I don't get turned into a drone!")
	pass
	
func _process(delta):
	var movement = Vector3(0,-7,0)
	move_and_slide(movement)