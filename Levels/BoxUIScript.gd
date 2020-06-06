extends Control

func update_stat_text_recruit(personable, hardworking, creative, recruit_name):
	var text = "Name: " + str(recruit_name) + ". \n"
	text += "Personable: " + str(personable) + "\n"
	text += "Hardworking: " + str(hardworking) + "\n"
	text += "Creativity: " + str(creative) + "\n"
	update_description(text)
	
func update_stat_text_drone(emote, productivity, innovation, charge, drone_id):
	var text = "Drone ID: " + str(drone_id) + ". \n"
	text += "Productivity: " + str(productivity) + "\n"
	text += "Emotional intelligence: " + str(emote) + "\n"
	text += "innovation: " + str(innovation) + "\n"
	text += "Charge level: " + str(charge) + "%\n"
	update_description(text)


func update_description(text):
	$BottomBarPanel/DescriptionScrollContainer/DescriptionText.text = text
