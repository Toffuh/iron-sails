extends Node2D

@onready var gameMap: GameMap = %GameMap


func _ready() -> void:
	gameMap.create_random_map()
