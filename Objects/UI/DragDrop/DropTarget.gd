extends Sprite3D

var growing = true
var speed = 0.06
export var max_size = 2
export var min_size = 1

func _process(delta):
	if scale.x > max_size: #shrink
		growing = false
	elif scale.x < min_size: #grow
		growing = true	
		
	if visible:
		scale.x = lerp(scale.x, max_size+0.01 if growing else min_size-0.01, speed)
		scale.z = lerp(scale.z, max_size+0.01 if growing else min_size-0.01, speed)
		rotate_y(speed)