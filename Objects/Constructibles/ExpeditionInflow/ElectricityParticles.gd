extends Particles

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Particles alive!!!!!!!!!")
	$Timer.connect("timeout",self,"die_bitch")
	emitting = true
	
func die_bitch():
	print("im DEAD")
	queue_free()
