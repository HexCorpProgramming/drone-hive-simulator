extends Timer

var drone_id = "0000"
var expedition_type = null
signal expedition_timer_complete

func _ready():
	print("Timer started!")
	connect("timeout",self,"timeout_with_id")
	connect("expedition_timer_complete",DroneManagement,"expedition_complete")
	
func timeout_with_id():
	print("Timer for ", str(drone_id), " completed")
	emit_signal("expedition_timer_complete",drone_id,expedition_type)
	queue_free()