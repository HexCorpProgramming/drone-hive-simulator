extends Spatial

var timer = 0
var subject_source = load("res://Objects/Subject.tscn")

func _ready():
	print("Spawner spawned. Ready to spawn.")
	
func _process(delta):
	timer += 1
	if timer >= 1000:
		var new_subject = subject_source.instance()
		add_child(new_subject)
		timer = 0