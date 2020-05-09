extends Spatial

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		var cast = raycast_from_camera_to_mouse()
		if cast:
			print(cast.collider)
			if cast.collider.has_method("playAnim"):
				cast.collider.playAnim()

func _input(event):
	if GameState.get_state() != 0: #Walking
		return
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var cast = raycast_from_camera_to_mouse()
		if cast:
			if cast.collider.is_in_group("Subject"):
				print("We got one boys")
				$UI.update_stat_text(cast.collider.personable, cast.collider.hardworking, cast.collider.creative, cast.collider.recruit_name)

func raycast_from_camera_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_position)
	var normal = get_viewport().get_camera().project_ray_normal(mouse_position)
	var to = from + normal * 100
	return get_world().direct_space_state.intersect_ray(from, to)