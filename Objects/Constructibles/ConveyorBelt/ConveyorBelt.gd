extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"	
func _process(delta):
	$Body/Collision/Mesh.get_surface_material(1).uv1_offset.y += 0.01