extends Button

export(PackedScene) var item_source
export var inactive_offset = 30
export var active_offset = 2
export var active_offset_max = 10
export var item_description = "ADD DESCRIPTION HERE"
var spawned_item
var offscreen = Vector3(0,inactive_offset,0)
onready var viewport = get_viewport()
onready var camera = viewport.get_camera()
onready var space_state = $WorldGetter.get_world().direct_space_state
onready var drop_target = get_node("../../../../DropTarget")

func _ready():
	self.connect("pressed",self,"on_pressed")

func on_pressed():
	pass
	# TODO: set item to be placed
