extends Control

var menu_visible: bool = false


func _ready():
	visible = menu_visible


func _process(_delta):
	if Input.is_action_just_pressed("game_menu"):
		toggle_menu()


func toggle_menu():
	menu_visible = !menu_visible
	visible = menu_visible


func _on_button_pressed() -> void:
	print("Button wurde gedrückt!")
