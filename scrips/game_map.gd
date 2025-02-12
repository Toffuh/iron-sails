@tool
extends Node2D

@onready var water_map: TileMapLayer = $Water
@onready var island_map: TileMapLayer = $Islands

@export var generate_new_map: bool:
	set(value):
		generate_new_map = false
		create_random_map()

@export var map_width: int = 64
@export var map_height: int = 32


func create_random_map():
	create_water()
	create_islands()


func create_islands():
	island_map.clear()

	for x in range(4):
		spawn_random_island()


func spawn_random_island():
	var x_range: int = map_width / 2
	var y_range: int = map_height / 2

	var x: int      = randi_range(-x_range + 3, x_range - 3)
	var y: int      = randi_range(-y_range + 3, y_range - 3)
	var width: int  = randi_range(2, 4)
	var height: int = randi_range(2, 4)

	fill_map(island_map, range(x - floori( width / 2.0), x + ceili( width / 2.0)), range(y - floori( height / 2.0), y + ceili( height / 2.0)))


func create_water():
	water_map.clear()
	fill_map(water_map, range(-map_width / 2, map_width / 2), range(-map_height / 2, map_height / 2))


func fill_map(map: TileMapLayer, x_range: Array, y_range: Array):
	var tiles: Array[Vector2i] = []

	for x in x_range:
		for y in y_range:
			tiles.push_back(Vector2i(x, y))

	map.set_cells_terrain_connect(tiles, 0, 0)
