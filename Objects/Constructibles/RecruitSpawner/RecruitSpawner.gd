extends Spatial

var delay = 5
var tick = 0
var subject_source = load("res://Objects/Recruit.tscn")
var spawn_recruits = true

func _ready():
	print("Spawner spawned. Ready to spawn.")
	get_node("../ToggleButton").connect("input_event",self,"toggle_spawn")
	
func tick():
	tick += 1
	if tick == delay and spawn_recruits:
		var new_subject = subject_source.instance()
		new_subject.translation = get_global_transform().origin
		get_tree().get_root().add_child(new_subject)
	
	if tick == delay:
		tick = 0
		
func toggle_spawn(camera, event, click_pos, click_norm, shape_idx):
	if Input.is_action_just_pressed("click"):
		spawn_recruits = !spawn_recruits
		get_node("../SpotLight").light_color = Color(1,0.4,1,0) if spawn_recruits else Color(1,0.4,0.4,0)