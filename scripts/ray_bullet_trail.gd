extends Node3D

class_name RayBulletTrail

var end: Vector3
var speed: float = 100
var start: Vector3
var direction: Vector3

func _ready() -> void:
	start = position
	direction = (end - start).normalized()

func _process(delta: float) -> void:
	position += direction * delta * speed
	
	if (position - end).normalized() == -direction:
		position = end
		queue_free()
