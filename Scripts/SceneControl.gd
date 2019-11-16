extends Node

enum LEVEL_LIST { LevelBox, LevelTest, SomeOtherSelection }
export(LEVEL_LIST) var level = LEVEL_LIST.LevelBox

func _ready():
	print(get_tree().get_nodes_in_group("Cubes"))