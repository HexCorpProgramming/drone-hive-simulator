extends Camera

onready var playerDrone = get_node("/root/Level/PlayerDrone/")
onready var space_state = get_world().direct_space_state

var MIN_OFFSET_HEIGHT = 0
export var MAX_OFFSET_HEIGHT = 4
export var MAX_DOWNWARD_TILT = -60
export var DISTANCE_FROM_DRONE = 10

var offset = Vector3(0,0,DISTANCE_FROM_DRONE)
var collision_avoidance_offset = Vector3(0,0,-0.1)
var raycastResult

func _process(delta):
	
	#Cast a ray to see if there's anything in the way of the camera.
	raycastResult = space_state.intersect_ray(playerDrone.translation, playerDrone.translation + offset, [self, playerDrone])
	
	#If there is something in the way, move the camera to the intersection.
	if(raycastResult):
		translation = raycastResult.position + collision_avoidance_offset
		translation.y += lerp(MAX_OFFSET_HEIGHT, MIN_OFFSET_HEIGHT, (raycastResult.position.z - playerDrone.translation.z) / 10) 
	#If not, just offset the camera from the drone's position.
	else:
		translation = playerDrone.translation + offset
		
	#Then, point the camera at the drone.
	look_at(playerDrone.translation, Vector3(0,1,0))
	
	#But reel it back if the camera is tilting too far downward.
	if(rotation_degrees.x < MAX_DOWNWARD_TILT):
		rotation_degrees.x = MAX_DOWNWARD_TILT
	