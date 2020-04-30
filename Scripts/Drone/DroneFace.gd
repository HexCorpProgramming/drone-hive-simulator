extends Spatial
export var headBob = 0.1
onready var droneBody = get_node("../Body")
onready var sceneControl = get_node("/root/Level/SceneControl/")

func _ready():
	
	match(SceneTools.level):
		0: #LevelBox
			print("Current level is LevelBox.")
			var IDToggle = get_node("../../UI/IDToggle")
			var IDAssign = get_node("../../UI/IDAssign")
			IDToggle.connect("toggled",self,"on_button_Toggled")
			IDAssign.connect("text_changed",self,"assign_id")
			print("LevelBox UI elements assigned to PlayerDrone's face.")
			
		_: #Default
			print("The PlayerDrone is in an unfamiliar level. Failed to associate UI elements.")
			print(get_owner().get_parent().get_name())


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