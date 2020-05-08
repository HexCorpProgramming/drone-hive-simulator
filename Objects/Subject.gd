extends KinematicBody

func _ready():
	print("I'm a subject and I sure do hope I don't get turned into a drone!")
	
func _process(delta):
	var movement = Vector3(0.1,0,0)
	if !is_on_floor():
		movement.y = -0.1
	move_and_collide(movement)