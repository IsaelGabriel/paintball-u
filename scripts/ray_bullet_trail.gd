extends Node3D

class_name RayBulletTrail

var end: Vector3
var speed: float = 125
var start: Vector3
var direction: Vector3
var t: float
var splatter: Node3D = null

func _process(delta: float) -> void:
	t += delta/(end - start).length() * speed
	position = start.lerp(end, t)
	
	if t >= 1:
		if splatter != null:
			splatter.visible = true
		
		queue_free()
