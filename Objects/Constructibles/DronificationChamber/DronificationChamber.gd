extends Constructible

var progress = 0
var completion = 3

var drone_source = load("res://Objects/Drones/Drone/Drone.tscn")

func playAnim():
	get_node("../AnimationPlayer").play("default")
	
func _ready():
	money_cost = 1
	nanite_cost = 1
	$ApproachingCollider.connect("body_entered",self,"on_object_approach")
	$ApproachingCollider.connect("body_exited",self,"on_object_leave")
	$Tween.connect("tween_all_completed",self,"drone_conversion_completed")
	
func on_object_approach(object):
	print("Oh lawdy it coming")
	$AnimationPlayer.queue("Open")

func on_object_leave(object):
	print("Oh lawdy it goin")
	$AnimationPlayer.queue("Close")
	
func drone_conversion_completed():
	$AnimationPlayer.queue("Close")
	
func make_drone_from_recruit(recruit):
	#mister, i'll make a drone out of you
	var converted_drone = drone_source.instance()
	converted_drone.emotional_intelligence = recruit.personable
	converted_drone.productivity = recruit.hardworking
	converted_drone.innovative = recruit.creative
	converted_drone.translation = recruit.translation
	get_tree().get_root().add_child(converted_drone)
	recruit.queue_free()
	
func tick():
	var relevant_object = $InternalArea.get_overlapping_bodies()
	if len(relevant_object) != 0:
		relevant_object = relevant_object[0]
		progress += 1
	
	if progress == completion - 1:
		#Convert the drone now and open the doors.
		if relevant_object.is_in_group("Recruit"):
			make_drone_from_recruit(relevant_object)
		$AnimationPlayer.play("Open")
	
	if progress == completion:
		#Output the drone at this point.
		var target_pos = $OutputPosition.get_global_transform().origin
		target_pos.y = relevant_object.get_global_transform().origin.y
		$Tween.interpolate_property(relevant_object, "translation", relevant_object.translation, target_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		progress = 0
		
	