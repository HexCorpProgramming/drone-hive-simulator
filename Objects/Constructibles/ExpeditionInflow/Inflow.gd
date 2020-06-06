extends Spatial

onready var puff_o_thunder = load("res://Objects/Constructibles/ExpeditionOutlet/ElectricityParticles.tscn")

var drone_queue = []
onready var drone_source = load("res://Objects/Drones/Drone/Drone.tscn")

func ready():
	print("SUP BIIITCH")
	print(puff_o_thunder)

func tick():
	if len(drone_queue) != 0:
		var drone_stats = DroneManagement.retrieve_expedition_drone(drone_queue.pop_front())
		var new_drone = drone_source.instance()
		new_drone.translation = $SpawnPoint.get_global_transform().origin
		new_drone.drone_id = drone_stats.drone_id
		var thunder_particles = puff_o_thunder.instance()
		thunder_particles.translation = $SpawnPoint.translation
		$SpawnPoint.add_child(thunder_particles)
		get_tree().get_root().add_child(new_drone)