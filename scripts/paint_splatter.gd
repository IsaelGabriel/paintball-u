extends Node3D

@onready var particles: GPUParticles3D = $GPUParticles3D


func _on_visibility_changed() -> void:
	if visible:
		particles.restart()
