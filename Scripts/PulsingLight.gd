extends OmniLight

func _ready():
	pass # Replace with function body.

func _process(delta):
	light_energy = light_energy + 0.1
	#print(light_energy)
	if light_energy > 10:
		light_energy = 0
