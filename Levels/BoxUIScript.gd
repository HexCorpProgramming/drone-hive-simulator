extends Control

func update_stat_text(personable, hardworking, creative):
	$StatLabel.visible = true
	$StatLabel.text = "Personable: " + str(personable) + "\n"
	$StatLabel.text += "Hardworking: " + str(hardworking) + "\n"
	$StatLabel.text += "Creativity: " + str(creative) + "\n"