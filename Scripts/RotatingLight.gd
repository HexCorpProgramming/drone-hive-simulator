extends DirectionalLight

func _ready():
	pass 
func _process(delta):
	rotation_degrees.y = rotation_degrees.y + 1
