extends Button

export var relevant_state = "WALKING"

func _ready():
	self.connect("button_up",self,"on_button_click")

func on_button_click():
	GameState.set_state(relevant_state)
