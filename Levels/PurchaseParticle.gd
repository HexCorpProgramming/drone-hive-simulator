extends Particles2D

func _ready():
	$Timer.connect("timeout",self,"delete")
	
func delete():
	queue_free()