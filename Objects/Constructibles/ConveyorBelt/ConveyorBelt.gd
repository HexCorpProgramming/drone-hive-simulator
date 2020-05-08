extends Spatial

var move = false

func _ready():
	$Timer.connect("timeout",self,"stop_moving")

func _process(delta):
	if move:
		$Body/Collision/Mesh.get_surface_material(1).uv1_offset.y += 0.01
	
func tick():
	move = true
	print("This conveyor belt is being ticked.")
	$Timer.start(1)
	
func stop_moving():
	move = false
	