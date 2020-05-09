extends Spatial

var tick_length = 2

func _ready():
	$Timer.connect("timeout",self,"factory_tick")
	$Timer.start(tick_length)
	
func factory_tick():
	for component in get_tree().get_nodes_in_group("Tickable"):
		component.tick()
	$Timer.start(tick_length)
