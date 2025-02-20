@icon("res://assets/icons/node_2d/controller.svg")
extends Node2D

@onready var gameMap: GameMap = %GameMap


func _ready() -> void:
	gameMap.create_random_map()
