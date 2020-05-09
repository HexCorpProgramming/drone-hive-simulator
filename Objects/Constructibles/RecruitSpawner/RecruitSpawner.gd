extends Spatial

var delay = 5
var tick = 0
var subject_source = load("res://Objects/Recruit.tscn")

func _ready():
	print("Spawner spawned. Ready to spawn.")
	
func tick():
	tick += 1
	if tick == delay:
		var new_subject = subject_source.instance()
		new_subject.translation = get_global_transform().origin
		get_tree().get_root().add_child(new_subject)
		tick = 0