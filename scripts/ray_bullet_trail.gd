extends Node3D

class_name RayBulletTrail

var end: Vector3
var speed: float = 75
var start: Vector3
var direction: Vector3
var t: float

func _process(delta: float) -> void:
	t += delta/(end - start).length() * speed
	position = start.lerp(end, t)
	
	if t >= 1:
		queue_free()
