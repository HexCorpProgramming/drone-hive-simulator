extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("beepboop"):
		var cast = raycast_from_camera_to_mouse()
		if cast:
			print(cast.collider)
			if cast.collider.has_method("playAnim"):
				cast.collider.playAnim()
		
func raycast_from_camera_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_position)
	var normal = get_viewport().get_camera().project_ray_normal(mouse_position)
	var to = from + normal * 100
	return get_world().direct_space_state.intersect_ray(from, to)