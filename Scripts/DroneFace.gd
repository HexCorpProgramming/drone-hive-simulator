extends Spatial
export var headBob = 0.1
onready var droneBody = get_node("../../Body")

func _ready():
	
	match(get_owner().get_parent().get_name()):
		"LevelBox":
			print("Current level is LevelBox.")
			var IDToggle = get_node("../../../UI/IDToggle")
			var IDAssign = get_node("../../../UI/IDAssign")
			IDToggle.connect("toggled",self,"on_button_Toggled")
			IDAssign.connect("text_changed",self,"assign_id")
			print("LevelBox UI elements assigned to PlayerDrone's face.")
			
		_:
			print("The PlayerDrone is in an unfamiliar level. Failed to associate UI elements.")
			print(get_owner().get_parent().get_name())

func _process(delta):
	
	#this if statement checks the walk animation frame and, if the drone is currently bobbing, it makes the face bob in time with the rest of the drone.
	if droneBody.frame == 1 or droneBody.frame == 3: #frames 1 and 3 have the drone bobbing down lower than normal.
		translation.y = 2 - headBob
	else:
		translation.y = 2
		
func on_button_Toggled(ticked):
	
	#Purpose: Receives the button toggle signal from a UI element and alters the drones facial state (displaying emotion or an ID).
	
	if ticked:
		$ID.visible = true
		$Emotion.visible = false
	else:
		$ID.visible = false
		$Emotion.visible = true
		
func assign_id(droneID):

	#Purpose: Receives a user input, checks if it is a valid drone ID (4 digit number), and sets it as the drone ID if valid.
	
	if(!id_is_numeric(droneID)):
		randomize_id(droneID)
	update_display(prepend_id_with_zeros(droneID))
	
func update_display(droneID):
	
	#Purpose: Updates each drone ID digit with the corresponding digit in the now-validated "droneID" string.
	
	$ID/Digit1.frame = int(droneID.substr(0,1))
	$ID/Digit2.frame = int(droneID.substr(1,1))
	$ID/Digit3.frame = int(droneID.substr(2,1))
	$ID/Digit4.frame = int(droneID.substr(3,1))

func randomize_id(droneID):
	
	#Purpose:
	
	randomize()
	droneID = str(randi()%10000+1) #if it fails the validation, the drone is assigned a new, random ID
		
func id_is_numeric(droneID):
	
	#Purpose:
	
		for i in range(0,droneID.length()):
			if !(droneID.substr(i,1).is_valid_integer()): #type validation (full ID must be only integers).
				return false
		return true
		
func prepend_id_with_zeros(droneID):
	
	#Purpose:
	
	print("Beginning drone ID prepend.")
	
	droneID = droneID.substr(0,4)
	while(droneID.length() != 4):
		print("Prepending 0 to drone ID.")
		droneID = "0" + droneID
	return droneID