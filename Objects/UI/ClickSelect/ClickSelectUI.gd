extends Control

var picked_item = null
var item_preview = null

onready var PlayerDrone = load("res://Objects/Drones/PlayerDrone/PlayerDrone.tscn")

var vertical_offset = Vector3(0,7,0)

const floor_tile = preload("res://Objects/Tiles/BasicTile.tscn")

func add_button():
	var button = load("res://Objects/UI/ClickSelect/ClickSelectButton.tscn").instance()
	$PanelContainer/ScrollContainer/HBoxContainer.add_child(button)
	
func set_item(item):
	$DropTarget.visible = false
	if item_preview:
		item_preview.queue_free()
		item_preview = null
	print("Item is", item)
	picked_item = item
	if item:
		item_preview = picked_item.instance()
		add_child(item_preview)
		item_preview.visible = false
		item_preview.translation = Vector3(0,50,0)
	
func _ready():
	visible = false
	
func _process(delta):
	if picked_item:
		handle_item_preview()
		handle_drop_target()
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and picked_item:
		print("Mouse clicked!")
		var found_floor = raycast_from_object_to_ground(item_preview)
		if found_floor:
			print(found_floor.collider)
		if found_floor and found_floor.collider.is_in_group("Floor"): 
			print("floor found.")
			print(found_floor.collider.translation)
			var spawned_item = picked_item.instance()
			add_child(spawned_item)
			spawned_item.translation = found_floor.collider.translation
	if Input.is_action_just_pressed("clickdrop_cancel_item"):
		set_item(null)
		
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
		print(result.collider.translation)
		print(result.collider.get_global_transform().origin)
		$DropTarget.visible = true
		item_preview.visible = true
		item_preview.translation = lerp(item_preview.translation, result.collider.get_global_transform().origin + vertical_offset, 0.1)
		
func raycast_from_camera_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_position)
	var normal = get_viewport().get_camera().project_ray_normal(mouse_position)
	var to = from + normal * 100
	return $WorldGetter.get_world().direct_space_state.intersect_ray(from, to)
	
func raycast_from_object_to_ground(object, avoid = null):
	 return $WorldGetter.get_world().direct_space_state.intersect_ray(item_preview.translation, item_preview.translation - Vector3(0,50,0), [avoid], 1)
