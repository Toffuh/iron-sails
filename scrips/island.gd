@tool
@icon("res://assets/icons/node_2d/island.svg")

class_name Island
extends Node2D

@onready var tile_map: TileMapLayer = $TileMap
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

@export var regenerate: bool:
	set(value):
		regenerate = false
		if Engine.is_editor_hint():
			generate()


func generate() -> void:
	if tile_map == null:
		return

	tile_map.clear()

	var width: int  = randi_range(2, 4)
	var height: int = randi_range(2, 4)

	var x_range: Array = range(-floori( width / 2.0), ceili( width / 2.0))
	var y_range: Array = range(-floori( height / 2.0), ceili( height / 2.0))

	Maps.fill_map(tile_map, x_range, y_range)

	var tile_sizes: Vector2i = tile_map.tile_set.tile_size

	var shape: RectangleShape2D = RectangleShape2D.new()
	collision_shape.shape = shape
	shape.size = Vector2(tile_sizes.x * (width -1), tile_sizes.y * (height -1))
	collision_shape.position = Vector2(_center(x_range) * tile_sizes.x, _center(y_range) * tile_sizes.y)


func _center(values: Array) -> float:
	var lower_index: int = floori( values.size() / 2.0)
	var upper_index: int = ceili( values.size() / 2.0)

	if lower_index == upper_index:
		return values[lower_index]

	return (values[lower_index] + values[upper_index]) / 2.


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT: #
		print("clicked island - " + get_name())
