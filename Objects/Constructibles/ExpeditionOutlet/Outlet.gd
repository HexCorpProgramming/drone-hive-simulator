extends Spatial

onready var puff_o_thunder = load("res://Objects/Constructibles/ExpeditionOutlet/ElectricityParticles.tscn")

func ready():
	print(puff_o_thunder)

func tick():
	if len($Area.get_overlapping_bodies()) != 0:
		var drone = $Area.get_overlapping_bodies()[0]
		DroneManagement.register_expedition_drone(drone)
		var disappearing_particles = puff_o_thunder.instance()
		$Area/CollisionShape.add_child(disappearing_particles)