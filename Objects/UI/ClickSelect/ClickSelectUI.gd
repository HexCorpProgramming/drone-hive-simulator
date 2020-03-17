extends Control

var picked_item = null
var item_preview = null

var vertical_offset = Vector3(0,7,0)
var last_known_location = Vector3(0,50,0)

const floor_tile = preload("res://Objects/Tiles/BasicTile.tscn")

func add_button():
	var button = load("res://Objects/UI/ClickSelect/ClickSelectButton.tscn").instance()
	$PanelContainer/ScrollContainer/HBoxContainer.add_child(button)
	
func set_item(item):
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
		item_preview.get_child(0).disabled = true
	
func _ready():
	visible = false
	
func _process(delta):
	if picked_item: #If we have an item ready to place, we should have a copy of it follow the mouse.
		var result = raycast_from_camera_to_mouse()
		if result and !result.collider.is_in_group("Wall"):
			item_preview.visible = true
			item_preview.translation = lerp(item_preview.translation, result.collider.translation + vertical_offset, 0.1)
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and picked_item:
		print("Mouse clicked!")
		var found_floor = $WorldGetter.get_world().direct_space_state.intersect_ray(item_preview.translation, item_preview.translation - Vector3(0,50,0))
		if found_floor and found_floor.collider.is_in_group("Floor"): 
			print("floor found.")
			var spawned_item = picked_item.instance()
			add_child(spawned_item)
			var item_size = spawned_item.get_child(0).get_child(0).get_aabb().size.y
			spawned_item.translation = found_floor.collider.translation + Vector3(0, item_size * 2, 0)

		
func raycast_from_camera_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_position)
	var normal = get_viewport().get_camera().project_ray_normal(mouse_position)
	var to = from + normal * 100
	return $WorldGetter.get_world().direct_space_state.intersect_ray(from, to, [item_preview])
