extends KinematicBody

var drone_id = 0000
var emotional_intelligence = 0
var productivity = 0
var innovative = 0
var charge = 100

var gravity = Vector3(0,-7,0)

func _ready():
	charge = 100
	print("Drone will obey HexCorp.")
	
func _process(delta):
	move_and_slide(gravity)