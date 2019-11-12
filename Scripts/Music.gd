extends AudioStreamPlayer

func _ready():
	var button = get_node("../../UI/Button")
	button.connect("pressed", self, "toggle_music")

func toggle_music():
	if self.is_playing():
		self.stop()
	else:
		self.play()
