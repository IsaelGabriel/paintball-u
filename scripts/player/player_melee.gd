extends Node3D

@onready var animator: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p_melee") and not visible:
			visible = true
			animator.play("hammer-hit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	visible = false
