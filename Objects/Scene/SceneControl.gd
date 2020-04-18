extends Node

enum LEVEL_LIST { LevelBox, LevelTest, SomeOtherSelection }
export(LEVEL_LIST) var level = LEVEL_LIST.LevelBox

func _ready():
	if get_tree().get_root().get_child(0) is Node2D:
		print("SceneControl is on 2D level. Turn off 3d cameras.")
		$PlayerCamera.active = false
		$EditCamera.active = false
		
func get_playercamera():
	return $PlayerCamera
	
func get_editcamera():
	return $EditCamera