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

func _ready():
	for id in range(0,10000):
		all_drone_ids.append(null)
		
	#Insert reserved IDs:
	all_drone_ids[0] = "Do not use." #0000
	all_drone_ids[6] = "Hive Mxtress." #0006

func generate_id() -> String:
	
	var int_id = 0
	
	for drone in all_drone_ids:
		if drone == null:
			break
		else:
			int_id += 1
	
	var str_id = str(int_id).pad_zeros(4)
	all_drone_ids[int_id] = str_id
	return str_id
	

func register_new_drone(drone_id) -> bool:
	if all_drone_ids.has(drone_id):
		return false
	all_drone_ids.append(drone_id)
	return true

func register_expedition_drone(drone) -> bool:
	for exp_drone in expedition_drones:
		if exp_drone.drone_id == drone.drone_id:
			print("Given drone is already on an expedition.")
			return false
	
	var drone_stats = _get_stats_from_drone(drone)
	expedition_drones.append(drone_stats)
	return true

func retrieve_expedition_drone(drone_id) -> DroneStats:
	for drone in expedition_drones:
		if drone.drone_id == drone_id:
			print("Drone found on expedition.")
			stored_drones.erase(drone)
			return drone
	return null
	
func register_stored_drone(drone) -> bool:
	for str_drone in stored_drones:
		if str_drone.drone_id == drone.drone_id:
			print("Given drone is already stored.")
			return false
	
	var drone_stats = _get_stats_from_drone(drone)
	stored_drones.append(drone_stats)
	return true
	
func retrieve_stored_drone(drone_id):
	for drone in stored_drones:
		if drone.drone_id == drone_id:
			print("Drone found in storage.")
			stored_drones.erase(drone)
			return drone
	return null

func _get_stats_from_drone(drone):
	var drone_stats = DroneStats.new()
	drone_stats.drone_id = drone.drone_id
	drone_stats.emotional_intelligence = drone.emotional_intelligence
	drone_stats.productivity = drone.productivity
	drone_stats.innovative = drone.innovative
	drone_stats.charge = drone.charge
	return drone_stats