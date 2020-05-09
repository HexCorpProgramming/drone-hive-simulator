extends Spatial
export var headBob = 0.1
onready var droneBody = get_node("../Body")

func _process(delta):
	
	#This if statement checks the walk animation frame and, if the drone is currently bobbing, it makes the face bob in time with the rest of the drone.
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
	update_display(droneID)


func update_display(droneID):
	
	#Purpose: Updates each drone ID digit with the corresponding digit in the now-validated "droneID" string.
	
	$ID/Digit1.frame = int(droneID.substr(0,1))
	$ID/Digit2.frame = int(droneID.substr(1,1))
	$ID/Digit3.frame = int(droneID.substr(2,1))
	$ID/Digit4.frame = int(droneID.substr(3,1))