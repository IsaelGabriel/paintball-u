extends CharacterBody3D

class_name Player

const GRAVITY = 9.8

const SPEED = 5

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	move_and_slide()

func _process(delta: float) -> void:
	_move(delta)

func _move(delta: float) -> void:
	var movement_input = Input.get_vector("p_left", "p_right", "p_back", "p_forward")
	velocity.x = movement_input.x * SPEED
	velocity.z = -movement_input.y * SPEED
