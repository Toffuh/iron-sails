@tool
@icon("res://assets/icons/node_2d/ship.svg")

class_name Ship
extends Node2D

# value representation is being used to index into the sprite sheet
enum Direction{
	NORTH = 2,
	EAST = 1,
	SOUTH = 0,
	WEST = 3
}
@onready var sprite: Sprite2D = $Sprite2D

@export var direction: Direction = Direction.NORTH:
	set(value):
		direction = value

		if(sprite != null):
			sprite.frame = value

@export var color: Color:
	set(value):
		color = value

		if(sprite != null):
			(sprite.material as ShaderMaterial).set_shader_parameter("new_color", Vector4(color.r, color.g, color.b, 1.))


func _ready() -> void:
	# needed to sync the current direction with the sprite
	direction = direction
	color = color
