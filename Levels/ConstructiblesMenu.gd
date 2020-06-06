extends ItemList

signal selected_item_description(text)

var picked_item = null

var vertical_offset = Vector3(0,7,0)
var max_height = 9

const floor_tile = preload("res://Objects/Tiles/BasicTile.tscn")

var constructibles = [
	"res://Objects/Constructibles/ConveyorBelt/ConveyorBelt.tscn", 
	"res://Objects/Constructibles/DronificationChamber/DronificationChamber.tscn", 
	"res://Objects/Constructibles/StoragePod/StoragePod.tscn"
]

var descriptions = [
	"Use this to transport items and recruits from A to B.",
	"Bring recruits here to turn them into cute, mindless drones.",
	"Recharging is extremely important for drone maintenance."
]

func _ready():
	visible = false

func _on_ModeSwitch_mode_changed(new_mode):
	if new_mode == GameState.STATES.EDITING:
		visible = true
	else:
		visible = false

func _on_ConstructiblesMenu_item_selected(index):
	set_item(load(constructibles[index]))
	emit_signal("selected_item_description", descriptions[index])

func set_item(item):
	print("Setting item: ", item)
	
	$DropTarget.visible = false
	if picked_item: #If there is already an item.
		picked_item.queue_free() #Delete it.
		picked_item = null #Like really fuckin wipe that suckaduck clean.
	picked_item = item
	
	if item is PackedScene:
		picked_item = item.instance()
	elif item: #Anything other than null.
		picked_item = item
		
	if item: #Only do this stuff if not null.
		add_child(picked_item)
		picked_item.visible = false
		picked_item.translation = Vector3(0,50,0)

	
func _process(delta):
	if picked_item and GameState.current_state == GameState.STATES.EDITING: #Edit mode
		handle_item_preview()
		handle_drop_target()
		$Indicator.visible = true
		$Indicator.rotation_degrees = picked_item.rotation_degrees
		$Indicator.translation = picked_item.translation
		picked_item.translation.y = min(picked_item.translation.y, max_height)
	else:
		$Indicator.visible = false
		
func _unhandled_input(event):
	if GameState.current_state != GameState.STATES.EDITING:
		return
	if Input.is_action_just_pressed("clickselect_drop_item") and picked_item:
		print("Mouse clicked!")
		var mouse_over_geometry = raycast_from_camera_to_mouse()
		if not mouse_over_geometry:
			print("But the mouse isn't over the floor so we won't spawn an item.")
			set_item(null)
			return
		var found_floor = raycast_from_object_to_ground(picked_item)
		if found_floor:
			print(found_floor.collider)
		if found_floor and found_floor.collider.is_in_group("Floor"):
			if picked_item.money_cost <= PlayerResources.money and picked_item.nanite_cost <= PlayerResources.nanites:
				print("A deal is made")
				PlayerResources.money -= picked_item.money_cost
				PlayerResources.nanites -= picked_item.nanite_cost
				
				PlayerResources.handle_particles()
				
				var spawned_item = picked_item.duplicate(6)
				spawned_item.rotation_degrees.y = picked_item.rotation_degrees.y
				add_child(spawned_item)
				spawned_item.translation = found_floor.collider.get_global_transform().origin
	elif Input.is_action_just_pressed("clickselect_drop_item") and not picked_item:
		print("Deleting")
		var cast = raycast_from_camera_to_mouse(false)
		if cast:
			print("Cast successful.")
			print(cast.collider)
			if cast.collider.is_in_group("Constructible"):
				#Refund the cost of the item.
				PlayerResources.money += cast.collider.money_cost
				PlayerResources.nanites += cast.collider.nanite_cost
			
				
				set_item(cast.collider)
	elif Input.is_action_just_pressed("clickdrop_cancel_item"):
		set_item(null)
	elif picked_item and Input.is_action_just_pressed("clickselect_rotate_clockwise"):
		print("Rotating >")
		picked_item.translation.y += 3
		picked_item.rotation_degrees.y += -90
	elif picked_item and Input.is_action_just_pressed("clickselect_rotate_counterclockwise"):
		print("Rotating <")
		picked_item.translation.y += 3
		picked_item.rotation_degrees.y += 90
		
		
func handle_drop_target():
	var drop_target_location = raycast_from_object_to_ground(picked_item)
	if drop_target_location:
		$DropTarget.translation = drop_target_location.position + Vector3(0,0.1,0)
		if drop_target_location.collider.is_in_group("Floor"):
			$DropTarget.valid = true
		elif drop_target_location.collider.is_in_group("Drone"): #We need a special case for the drone.
			var avoid_this_drone = drop_target_location.collider
			$DropTarget.visible = true
			$DropTarget.valid = false
			$DropTarget.translation = raycast_from_object_to_ground(picked_item, avoid_this_drone).position + Vector3(0,0.1,0) #i hate this code t. 5890
		else:
			$DropTarget.valid = false
	else:
		$DropTarget.visible = false
		
func handle_item_preview():
	var result = raycast_from_camera_to_mouse()
	if result:
		$DropTarget.visible = true
		picked_item.visible = true
		picked_item.translation = lerp(picked_item.translation, result.collider.get_global_transform().origin + vertical_offset, 0.1)
		
func raycast_from_camera_to_mouse(ignore_constructibles = true):
	var mouse_position = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_position)
	var normal = get_viewport().get_camera().project_ray_normal(mouse_position)
	var to = from + normal * 100
	if ignore_constructibles:
		return $WorldGetter.get_world().direct_space_state.intersect_ray(from, to, get_tree().get_nodes_in_group("Constructible"))
	else:
		return $WorldGetter.get_world().direct_space_state.intersect_ray(from, to)
func raycast_from_object_to_ground(object, avoid = null):
	 return $WorldGetter.get_world().direct_space_state.intersect_ray(picked_item.translation, picked_item.translation - Vector3(0,50,0), [avoid], 1)



