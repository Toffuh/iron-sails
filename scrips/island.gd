@tool
class_name Island
extends Node2D

@onready var tile_map: TileMapLayer = $TileMap

@export var regenerate: bool:
	set(value):
		regenerate = false
		if Engine.is_editor_hint():
			generate()


func generate():
	tile_map.clear()

	var width: int  = randi_range(2, 4)
	var height: int = randi_range(2, 4)

	Maps.fill_map(tile_map, range(-floori( width / 2.0), ceili( width / 2.0)), range(-floori( height / 2.0), ceili( height / 2.0)))
