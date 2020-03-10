extends Node

# Declare member variables here. Examples:
var droneID = "1211"

func change_id(ID):
	ID = prepend_id_with_zeros(ID)
	if id_is_numeric(ID):
		droneID = ID
	else:
		droneID = randomize_id()


func id_is_numeric(droneID):
	
	for i in range(0,droneID.length()):
		if !(droneID.substr(i,1).is_valid_integer()): #type validation (full ID must be only integers).
			return false
	return true


func prepend_id_with_zeros(droneID):
	
	#Purpose:
	
	print("Beginning drone ID prepend.")
	
	droneID = droneID.substr(0,4)
	while(droneID.length() != 4):
		print("Prepending 0 to drone ID.")
		droneID = "0" + droneID
	return droneID


func randomize_id():
	
	#Purpose: If it fails the validation, the drone is assigned a new, random ID
	randomize()
	return str(randi()%10000+1) 