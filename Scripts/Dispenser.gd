extends Button

export(PackedScene) var item_source
export var inactive_offset = 30
export var active_offset = 2
export var active_offset_max = 10
var spawned_item
var offscreen = Vector3(0,inactive_offset,0)
onready var viewport = get_viewport()
onready var camera = viewport.get_camera()
onready var space_state = $WorldGetter.get_world().direct_space_state
onready var drop_target = get_node("../../../../DropTarget")

func _ready():
	self.connect("pressed",self,"_on_pressed")
	self.connect("button_down",self,"_on_button_down")
	self.connect("button_up",self,"_on_button_up")
	print(space_state)
	print(item_source)

func _on_pressed():
	spawned_item = item_source.instance()
	spawned_item.translation = Vector3(0,30,0)
	spawned_item.visible = false
	get_tree().get_root().add_child(spawned_item)
	
func _on_button_up():
	print("Button released!")
	spawned_item = null
	drop_target.visible = false

func _process(delta):
	if spawned_item:
		offscreen = spawned_item.translation + Vector3(0,inactive_offset,0)
		
func _input(event):
	if event.is_action_pressed("ui_scroll_up") && spawned_item:
		print("Scroll up!")
		accept_event()
		if active_offset < active_offset_max:
			active_offset += 1
	if event.is_action_pressed("ui_scroll_down") && spawned_item:
		print("Scroll down!")
		accept_event()
		if active_offset > 1:
			active_offset -= 1

func _physics_process(delta):
	if spawned_item != null:
		viewport = get_viewport()
		camera = viewport.get_camera()
		var mouse_pos = viewport.get_mouse_position()
		var from = camera.project_ray_origin(mouse_pos)
		var normal = camera.project_ray_normal(mouse_pos)
		var to = from + normal * 100
		var result = space_state.intersect_ray(from, to, [spawned_item, self])
		if result:
			spawned_item.visible = true
			drop_target.visible = true
			spawned_item.translation = lerp(spawned_item.translation, result.position + Vector3(0,active_offset,0), 0.3)
			drop_target.translation = result.position + Vector3(0,0.1,0)
		else:
			spawned_item.translation = lerp(spawned_item.translation, offscreen, 0.05)
			drop_target.visible = false