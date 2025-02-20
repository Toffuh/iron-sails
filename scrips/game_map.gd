@tool
@icon("res://assets/icons/node_2d/map.svg")

class_name GameMap
extends Node2D

@onready var water_map: TileMapLayer = $Water
@onready var islands: Node2D = $Islands

var island_scene: PackedScene = preload("res://scenes/island.tscn")

@export var generate_new_map: bool:
	set(value):
		generate_new_map = false
		if Engine.is_editor_hint():
			create_random_map()

@export var map_width: int = 64
@export var map_height: int = 32
@export var island_count: int = 4
@export var min_island_distance: int = 12


func create_random_map():
	create_water()
	create_islands()


func create_islands():
	var children: Array[Node] = islands.get_children()
	for child in children:
		child.free()

	var island_locations: Array[Vector2i] = []

	for x in range(island_count):
		for y in range(0, 5):
			var location: Vector2i = random_island_location()

			var to_close: bool = false
			for other_location in island_locations:
				if other_location.distance_squared_to(location) < min_island_distance * min_island_distance:
					to_close = true
					break

			if to_close:
				continue

			island_locations.push_back(location)
			break

	for location in island_locations:
		spawn_island(location)


func random_island_location() -> Vector2i:
	var x_range: int = map_width / 2
	var y_range: int = map_height / 2

	var x: int = randi_range(-x_range + 3, x_range - 3)
	var y: int = randi_range(-y_range + 3, y_range - 3)

	return Vector2i(x, y)


func spawn_island(location: Vector2i):
	var island: Island = island_scene.instantiate()

	islands.add_child(island)
	# need to make the scene show up in the editor
	island.owner = islands.get_tree().edited_scene_root

	island.generate()

	island.position = Vector2(location.x * 16, location.y * 16)
	island.name = "Island " + str(islands.get_child_count())


func create_water():
	water_map.clear()
	Maps.fill_map(water_map, range(-map_width / 2, map_width / 2), range(-map_height / 2, map_height / 2))
