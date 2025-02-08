extends Camera2D

const ZOOM_RATE: float   = 8.0
const ZOOM_FACTOR: float = 1.1

@export var min_zoom: float = 0.1
@export var max_zoom: float = 1.0

var _target_zoom: float = zoom.x


func _physics_process(delta: float) -> void:
	zoom = lerp(zoom, _target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	set_physics_process(not is_equal_approx(zoom.x, _target_zoom))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_out()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_in()

	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			position -= event.relative / zoom


func zoom_in() -> void:
	_target_zoom = max(_target_zoom / ZOOM_FACTOR, min_zoom)
	set_physics_process(true)


func zoom_out() -> void:
	_target_zoom = min(_target_zoom * ZOOM_FACTOR, max_zoom)
	set_physics_process(true)
