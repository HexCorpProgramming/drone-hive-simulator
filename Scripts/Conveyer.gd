extends StaticBody

var speed = 0.01
onready var thisMesh = get_node("Collision/Mesh")
onready var thisMat = thisMesh.mesh.surface_get_material(1)

func _ready():
	thisMesh.mesh.surface_set_material(1, thisMat.duplicate())
	print(thisMat)
	print(thisMesh.mesh.surface_get_material(1))
	
	print(thisMesh.mesh.surface_get_material(1).uv1_offset)

func _physics_process(delta):
	thisMesh.mesh.surface_get_material(1).uv1_offset.y += self.speed
