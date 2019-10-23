extends StaticBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var foo = $Collision/Mesh.mesh.surface_get_material(1);
	var bar = $Collision/Mesh.mesh.surface_get_material(1);
	var heck = $Collision/Mesh.mesh.surface_get_material(2);
	print(foo.get_property_list())
	foo.flags_vertex_lighting = true;

func _process(delta):
	var foo = $Collision/Mesh.mesh.surface_get_material(1);
	foo.uv1_offset.y += 0.01
	foo.uv2_offset.y += 0.01
	#var bar = $Collision/Mesh.mesh.surface_get_material(0);
	#bar.uv1_offset.y += 0.1
