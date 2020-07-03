extends Constructible

var move = false

func _ready():
	money_cost = 5
	nanite_cost = 3
	$Timer.connect("timeout",self,"stop_moving")
	$Collision/Mesh.set_surface_material(1, $Collision/Mesh.get_surface_material(1).duplicate())
	
func _process(delta):
	if move:
		$Collision/Mesh.get_surface_material(1).uv1_offset.y += 0.01
	
func push_object():
	move = true
	#print("This conveyor belt is being ticked.")
	$Timer.start(1)
	var object_to_push = $PushArea.get_overlapping_bodies()
	if len(object_to_push) == 0:
		return
	object_to_push = object_to_push[0]
	
	var target_pos = $PushTarget.get_global_transform().origin
	target_pos.y = object_to_push.get_global_transform().origin.y
	
	$Tween.interpolate_property(object_to_push, "translation", object_to_push.translation, target_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	#print("My object to push is ", object_to_push.name)
	#print("The basis is ", transform.basis.x)
	
func stop_moving():
	move = false
	
func tick():
	print("Conveyor belt is totally moving rn")
	#Check what's ahead to determine if you're at the end of the conveyor chain
	#If storage pod or expedition zone: Can move
	#If nothing: Can't move if you have something on you.
	#If conveyor: Not at end of chain, do nothing until told.
	
	
	
func inform_previous_conveyor():
	print("Not implemented")
	
func get_object_on_conveyor():
	var object_to_push = $PushArea.get_overlapping_bodies()
	if len(object_to_push) == 0:
		return null
	object_to_push = object_to_push[0]
	
	if !(object_to_push is Drone) and !(object_to_push is Recruit):
		return null
	return object_to_push
	
