extends Control

func update_stat_text(personable, hardworking, creative, recruit_name):
	$StatLabel.visible = true
	$StatLabel.text = "Name: " + str(recruit_name) + ". \n"
	$StatLabel.text += "Personable: " + str(personable) + "\n"
	$StatLabel.text += "Hardworking: " + str(hardworking) + "\n"
	$StatLabel.text += "Creativity: " + str(creative) + "\n"