extends Node

class DroneStats:
	var drone_id = "0000"
	var emotional_intelligence = 0
	var productivity = 0
	var innovative = 0
	var charge = 100

var all_drone_ids = []
var expedition_drones = []
var stored_drones = []

func register_new_drone(drone):
	print("Not implemented.")

func register_expedition_drone(drone):
	for exp_drone in expedition_drones:
		if exp_drone.drone_id == drone.drone_id:
			print("Given drone is already on an expedition.")
			return
	
	var drone_stats = DroneStats.new()
	drone_stats.drone_id = drone.drone_id
	drone_stats.emotional_intelligence = drone.emotional_intelligence
	drone_stats.productivity = drone.productivity
	drone_stats.innovative = drone.innovative
	drone_stats.charge = drone.charge

func retrieve_expedition_drone(drone_id) -> DroneStats:
	for drone in expedition_drones:
		if drone.drone_id == drone_id:
			print("Drone found on expedition.")
			stored_drones.erase(drone)
			return drone
	return null
	
func register_stored_drone(drone):
	print("Not implemented.")
	
func retrieve_stored_drone(drone_id):
	for drone in stored_drones:
		if drone.drone_id == drone_id:
			print("Drone found in storage.")
			stored_drones.erase(drone)
			return drone
	return null

func _get_stats_from_drone(drone):
	#Drone must be a node path.
	print("Not implemented.")