extends Spatial

var tick_length = 2

func _ready():
	$Timer.connect("timeout",self,"timer_test")
	$Timer.start(tick_length)
	
func timer_test():
	for component in get_tree().get_nodes_in_group("Tickable"):
		component.tick()
	print("Factory tick.")
	$Timer.start(tick_length)
