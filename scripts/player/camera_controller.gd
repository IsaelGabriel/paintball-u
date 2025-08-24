extends Node3D

class_name CameraController

const SENSITIVITY = .005

var body: Player

func _ready() -> void:
	body = get_parent()

func _process(delta: float) -> void:
	var camera_input = -Input.get_last_mouse_velocity()
	
	body.rotate_y(camera_input.x * SENSITIVITY * delta)
	rotate_x(camera_input.y * SENSITIVITY * delta)
