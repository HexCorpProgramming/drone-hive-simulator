extends Sprite3D

var speed = 0.06
export var WARNING_COLOR = Color(0.66,0,0,1)
export var NEUTRAL_COLOR = Color(0.9,0.9,0.9,1)
var valid = true

func _process(delta):
	rotate_y(speed)
	
	if valid:
		modulate = lerp(modulate, NEUTRAL_COLOR, 0.1)
	else:
		modulate = lerp(modulate, WARNING_COLOR, 0.1)