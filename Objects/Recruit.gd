extends KinematicBody

#Expedition stats
var personable = 0
var hardworking = 0
var creative = 0
var recruit_name = null

func _ready():
	
	#Ensure randomocity.
	randomize()
	
	#Get a name
	recruit_name = SubjectNames.get_name()
	
	#Randomize expedition stats
	personable = randi() % 11
	hardworking = randi() % 11
	creative = randi() % 11
	
func _process(delta):
	var movement = Vector3(0,-7,0)
	move_and_slide(movement)
