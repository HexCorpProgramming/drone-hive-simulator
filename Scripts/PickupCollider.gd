extends CollisionShape

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pickedUp = false
var colliderActive = false
export(AudioStream) var pickupSound
export(AudioStream) var dropSound

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Collider ready.")


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		colliderActive = true
		print("Collider triggered.")
		
		if pickedUp:
			print("Item dropped.")
			$SFX.stream = dropSound
			$SFX.play()
			pickedUp = false
		else:
			print("Item picked up.")
			$SFX.stream = pickupSound
			$SFX.play()
			pickedUp = true
			
		colliderActive = false