extends Area

var thereIsAnObjectInsideMe = false

var isPushingObject = false
onready var conveyerParent = get_parent()
var currentObject

func _ready():
	connect("body_entered",self,"_on_ConveyerArea_body_entered")
	connect("body_exited",self,"_on_ConveyerArea_body_exited")


func _on_ConveyerArea_body_entered(body):
	
	print("body entered!")
	
	if body.get_name() != conveyerParent.get_name() and (!body.is_in_group("Tile")) and (!body.is_in_group("Conveyer")):
		thereIsAnObjectInsideMe = true
		currentObject = body
		currentObject.set_meta("pushedBy", conveyerParent.get_name())

func _on_ConveyerArea_body_exited(body):
	
	print("body exited!")
	
	thereIsAnObjectInsideMe = false
	
func _process(delta):
		
	if thereIsAnObjectInsideMe:
		currentObject.translation += (conveyerParent.get_global_transform().basis.x.normalized() * (conveyerParent.speed * 10))