extends Node3D

@export var damage: float = 2

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var player: Player = get_parent().get_parent()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p_melee") and not visible:
			visible = true
			animator.play("hammer-hit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	visible = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Damageable") and visible and body != player:
		for child in body.get_children():
			if child is not Damageable: continue
			child.deal_damage(player, damage)
