extends Camera

onready var playerDrone = get_node("/root/Level/PlayerDrone/")
onready var space_state = get_world().direct_space_state

var MIN_OFFSET_HEIGHT = 0
export var MAX_OFFSET_HEIGHT = 4
export var DISTANCE_FROM_DRONE = 10

var offset = Vector3(0,0,DISTANCE_FROM_DRONE)
var raycastResult

func _process(delta):
	
	#Set the camera position to the drone's position with an offset.
	translation = playerDrone.translation + offset
	
	#Cast a ray to see if there's anything in the way of the camera.
	raycastResult = space_state.intersect_ray(playerDrone.translation, playerDrone.translation + offset, [self, playerDrone])
	
	#If there is something in the way, use the distance from the collision to interpolate a vertical offset.
	if(raycastResult):
		translation.y += lerp(MAX_OFFSET_HEIGHT, MIN_OFFSET_HEIGHT, (raycastResult.position.z - playerDrone.translation.z) / 10) 
	#If not, offset the camera by the minimum value.
	else:
		translation.y += MIN_OFFSET_HEIGHT
		
	#Finally, point the camera at the drone.
	look_at(playerDrone.translation, Vector3(0,1,0))
	