extends Spatial

var move = false
var object_to_push = null

func _ready():
	$Timer.connect("timeout",self,"stop_moving")

func _process(delta):
	if move:
		$Body/Collision/Mesh.get_surface_material(1).uv1_offset.y += 0.01
	if object_to_push:
		print(get_global_transform().basis.x)
		object_to_push.translation += get_global_transform().basis.x * delta * 2.15
	
func tick():
	move = true
	#print("This conveyor belt is being ticked.")
	$Timer.start(1)
	object_to_push = $PushArea.get_overlapping_bodies()
	if len(object_to_push) == 0:
		return
	object_to_push = object_to_push[0]
	object_to_push.translation.x = get_global_transform().origin.x
	object_to_push.translation.z = get_global_transform().origin.z
	#print("My object to push is ", object_to_push.name)
	#print("The basis is ", transform.basis.x)
	
func stop_moving():
	move = false
	object_to_push = null
	