extends Control

var menu_visible = false

@onready var menu = $"."
@onready var button = $Button

func _ready():
	menu.visible = menu_visible

func _process(delta):
	if Input.is_action_just_pressed("game_menu"):  # "F" wurde gedrückt
		toggle_menu()

func toggle_menu():
	menu_visible = !menu_visible
	menu.visible = menu_visible

func _on_button_pressed() -> void:
	print("Button wurde gedrückt!")
