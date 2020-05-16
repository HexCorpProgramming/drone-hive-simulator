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
	print("Not implemented.")

func retrieve_expedition_drone(drone_id):
	#Delete drone from list and return its details.
	print("Not implemented.")
	
func register_stored_drone(drone):
	print("Not implemented.")
	
func retrieve_stored_drone(drone_id):
	#Delete drone from list and return its details.
	print("Not implemented.")

func _get_stats_from_drone(drone):
	#Drone must be a node path.
	print("Not implemented.")