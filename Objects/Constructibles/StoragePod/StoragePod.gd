extends Spatial

var money_cost = 3
var nanite_cost = 3

func playAnim():
	get_node("../AnimationPlayer").play("default")
	
func tick():
	var drone = $DroneDectector.get_overlapping_bodies()
	if len(drone) != 0:
		drone = drone[0]
		if not drone.is_in_group("Drone"): return
		DroneManagement.register_stored_drone(drone)
		$AnimationPlayer.play("default")
		print("Drone ", drone.drone_id, " stored. Successfully.")
		drone.queue_free()
		print("All drones in storage:")
		for stored_drone in DroneManagement.stored_drones:
			print(stored_drone.drone_id + " [" + 
			str(stored_drone.emotional_intelligence) + "/" + 
			str(stored_drone.productivity) + "/" + 
			str(stored_drone.innovative) + "/" +
			str(stored_drone.charge) + "]")
