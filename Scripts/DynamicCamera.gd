extends Camera

onready var playerDrone = get_node("/root/Level/PlayerDrone/")
onready var floorSpawner = get_node("/root/Level/SceneControl/FloorSpawner")
onready var space_state = get_world().direct_space_state

var offset = Vector3(0,0,10)
var raycastResult

func _process(delta):
	#Set camera to drone's position + offset.
	translation = playerDrone.translation + offset
	
	#Cast a ray to see if there's anything in the way.
	raycastResult = space_state.intersect_ray(playerDrone.translation, translation, [self, playerDrone])
	
	#If there is something in the way, move the camera to the intersection.
	if(raycastResult):
		translation = raycastResult.position 
