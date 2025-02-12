extends Node

@onready var menu = $CanvasLayer/Menu 

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		menu.visible = !menu.visible
		get_tree().paused = menu.visible
		
	
