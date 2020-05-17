extends Control

var picked_item = null
var item_preview = null

onready var PlayerDrone = load("res://Objects/Drones/PlayerDrone/PlayerDrone.tscn")

var vertical_offset = Vector3(0,7,0)
var max_height = 9

const floor_tile = preload("res://Objects/Tiles/BasicTile.tscn")

func add_button():
	var button = load("res://Objects/UI/ClickSelect/ClickSelectButton.tscn").instance()
	$PanelContainer/ScrollContainer/HBoxContainer.add_child(button)
	
func set_item(item):
	$DropTarget.visible = false
	if item_preview:
		item_preview.queue_free()
		item_preview = null
	print("Click select item update to: ", item)
	picked_item = item
	if item:
		item_preview = picked_item.instance()
		add_child(item_preview)
		item_preview.visible = false
		print("LOOKHERE")
		item_preview.find_node("Body").input_ray_pickable = false
		item_preview.translation = Vector3(0,50,0)
	
func _ready():
	visible = false
	
func _process(delta):
	if picked_item and GameState.get_state() == 1: #Edit mode
		handle_item_preview()
		handle_drop_target()
		$Indicator.visible = true
		$Indicator.rotation_degrees = item_preview.rotation_degrees
		$Indicator.translation = item_preview.translation
		item_preview.translation.y = min(item_preview.translation.y, max_height)
	else:
		$Indicator.visible = false
		
func _unhandled_input(event):
	if GameState.get_state() != 1: return
	if Input.is_action_just_pressed("clickselect_drop_item") and picked_item:
		print("Mouse clicked!")
		var mouse_over_geometry = raycast_from_camera_to_mouse()
		if not mouse_over_geometry:
			print("But the mouse isn't over the floor so we won't spawn an item.")
			set_item(null)
			return
		var found_floor = raycast_from_object_to_ground(item_preview)
		if found_floor:
			print(found_floor.collider)
		if found_floor and found_floor.collider.is_in_group("Floor"): 
			print("floor found.")
			var spawned_item = picked_item.instance()
			spawned_item.rotation_degrees.y = item_preview.rotation_degrees.y
			add_child(spawned_item)
			spawned_item.translation = found_floor.collider.get_global_transform().origin
	elif Input.is_action_just_pressed("clickdrop_cancel_item"):
		set_item(null)
	elif item_preview and Input.is_action_just_pressed("clickselect_rotate_clockwise"):
		print("Rotating >")
		item_preview.translation.y += 3
		item_preview.rotation_degrees.y += -90
	elif item_preview and Input.is_action_just_pressed("clickselect_rotate_counterclockwise"):
		print("Rotating <")
		item_preview.translation.y += 3
		item_preview.rotation_degrees.y += 90
		
		
func handle_drop_target():
	var drop_target_location = raycast_from_object_to_ground(item_preview)
	if drop_target_location:
		$DropTarget.translation = drop_target_location.position + Vector3(0,0.1,0)
		if drop_target_location.collider.is_in_group("Floor"):
			$DropTarget.valid = true
		elif drop_target_location.collider.is_in_group("Drone"): #We need a special case for the drone.
			var avoid_this_drone = drop_target_location.collider
			$DropTarget.visible = true
			$DropTarget.valid = false
			$DropTarget.translation = raycast_from_object_to_ground(item_preview, avoid_this_drone).position + Vector3(0,0.1,0) #i hate this code t. 5890
		else:
			$DropTarget.valid = false
	else:
		$DropTarget.visible = false
		
func handle_item_preview():
	var result = raycast_from_camera_to_mouse()
	if result:
		$DropTarget.visible = true
		item_preview.visible = true
		item_preview.translation = lerp(item_preview.translation, result.collider.get_global_transform().origin + vertical_offset, 0.1)
		
func raycast_from_camera_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_position)
	var normal = get_viewport().get_camera().project_ray_normal(mouse_position)
	var to = from + normal * 100
	return $WorldGetter.get_world().direct_space_state.intersect_ray(from, to, get_tree().get_nodes_in_group("Constructible"))
	
func raycast_from_object_to_ground(object, avoid = null):
	 return $WorldGetter.get_world().direct_space_state.intersect_ray(item_preview.translation, item_preview.translation - Vector3(0,50,0), [avoid], 1)
