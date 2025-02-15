@tool
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


func create_random_map():
	create_water()
	create_islands()


func create_islands():
	var children: Array[Node] = islands.get_children()
	for child in children:
		child.free()

	for x in range(4):
		spawn_random_island()


func spawn_random_island():
	var x_range: int = map_width / 2
	var y_range: int = map_height / 2

	var x: int = randi_range(-x_range + 3, x_range - 3)
	var y: int = randi_range(-y_range + 3, y_range - 3)

	var island: Island = island_scene.instantiate()

	islands.add_child(island)
	# need to make the scene show up in the editor
	island.owner = islands.get_tree().edited_scene_root

	island.generate()

	island.position = Vector2(x * 16, y * 16)
	island.name = "Island " + str(islands.get_child_count())


func create_water():
	water_map.clear()
	Maps.fill_map(water_map, range(-map_width / 2, map_width / 2), range(-map_height / 2, map_height / 2))
