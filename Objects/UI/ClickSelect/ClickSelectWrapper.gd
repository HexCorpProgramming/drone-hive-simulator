extends CanvasLayer

func set_item(item, item_description):
	$ClickSelect.set_item(item)
	get_node("InfoDisplay/PanelContainer/HBoxContainer/InfoText").text = item_description

func set_visible(boolean):
	$ClickSelect.visible = boolean
	$InfoDisplay.visible = boolean
