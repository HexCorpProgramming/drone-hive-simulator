extends Control

func update_stat_text_recruit(personable, hardworking, creative, recruit_name):
	$StatLabel.visible = true
	$StatLabel.text = "Name: " + str(recruit_name) + ". \n"
	$StatLabel.text += "Personable: " + str(personable) + "\n"
	$StatLabel.text += "Hardworking: " + str(hardworking) + "\n"
	$StatLabel.text += "Creativity: " + str(creative) + "\n"
	
func update_stat_text_drone(emote, productivity, innovation, charge, drone_id):
	$StatLabel.visible = true
	$StatLabel.text = "Drone ID: " + str(drone_id) + ". \n"
	$StatLabel.text += "Productivity: " + str(productivity) + "\n"
	$StatLabel.text += "Emotional intelligence: " + str(emote) + "\n"
	$StatLabel.text += "innovation: " + str(innovation) + "\n"
	$StatLabel.text += "Charge level: " + str(charge) + "%\n"