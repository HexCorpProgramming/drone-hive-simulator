extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$PickupBox1.connect("test1", self, "test2")

func test2():
	print("SECRET CUBE BUTTON FUCKING ACTIVATED")
