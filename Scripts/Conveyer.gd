extends StaticBody

export var speed = 0.01

func _ready():
	var foo = $Collision/Mesh.mesh.surface_get_material(1);
	var bar = $Collision/Mesh.mesh.surface_get_material(1);
	var heck = $Collision/Mesh.mesh.surface_get_material(2);
	foo.flags_vertex_lighting = true;

func _process(delta):
	var foo = $Collision/Mesh.mesh.surface_get_material(1);
	foo.uv1_offset.y += speed
	foo.uv2_offset.y += speed
