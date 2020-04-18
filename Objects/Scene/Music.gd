extends AudioStreamPlayer

func toggle_music():
	if self.is_playing():
		self.stop()
	else:
		self.play()
