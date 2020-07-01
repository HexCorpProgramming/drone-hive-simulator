extends KinematicBody
class_name Drone

# By default, the drone will stand there and do nothing.
# It has member variables for drone attribues,
# And helpful functions such as being able to set their ID.
# The PlayerDrone class extends Drone, and adds helpful movement functions.

var drone_id = "0000"
var emotional_intelligence = 0
var productivity = 0
var innovative = 0
var charge = 100

#Drone components (comdronenets)
onready var face = $Face
onready var emotion = $Face/Emotion
onready var digits = $Face/ID
onready var digit1 = $Face/ID/Digit1
onready var digit2 = $Face/ID/Digit2
onready var digit3 = $Face/ID/Digit3
onready var digit4 = $Face/ID/Digit4

var gravity = Vector3(0,-7,0)

func _ready():
	charge = 100
	if drone_id == "0000": #If a drone ID has not yet been set,
		drone_id = DroneManagement.generate_id() #Generate one randomly.
	set_drone_id(drone_id)
	print("Drone ", drone_id, " will obey HexCorp.")
	
func _process(delta):
	move_and_slide(gravity)
	
func set_drone_id(id):
	#Update the drone_id variable and update the visor.
	drone_id = str(id)
	digit1.frame = int(drone_id.substr(0,1))
	digit2.frame = int(drone_id.substr(1,1))
	digit3.frame = int(drone_id.substr(2,1))
	digit4.frame = int(drone_id.substr(3,1))
	
func toggle_display():
	print("Not implemented.")
