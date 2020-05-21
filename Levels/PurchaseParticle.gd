extends Particles2D

func _ready():
	emitting = true
	$Timer.connect("timeout",self,"delete")
	
func delete():
	queue_free()