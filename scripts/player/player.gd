extends CharacterBody3D

class_name Player

const GRAVITY = 15
const SPEED = 10
const SLIDE_SPEED = 40
const JUMP_FORCE = 15
const STOMP_FORCE = 40
const JUMP_STEER_FACTOR = 0.5

var sliding:bool = false
var slide_direction:Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	move_and_slide()

func _process(delta: float) -> void:
	_move(delta)

func _move(delta: float) -> void:
	if not Input.is_action_pressed("p_slide"):
		sliding = false
	
	
	var movement_input = Input.get_vector("p_left", "p_right", "p_back", "p_forward").normalized()
	
	if is_on_floor():
		
		
		if Input.is_action_just_pressed("p_jump"):
			velocity.y = JUMP_FORCE
		elif Input.is_action_pressed("p_slide") && not movement_input.is_zero_approx():
			if not sliding:
				slide_direction = movement_input
			sliding = true
			
		
		if not sliding:
			velocity.x = movement_input.x * SPEED
			velocity.z = -movement_input.y * SPEED
	else:
		if Input.is_action_just_pressed("p_slide"):
			velocity.y = -STOMP_FORCE
		
	if sliding:
		velocity.z = -slide_direction.y * SLIDE_SPEED
		velocity.x = slide_direction.x * SLIDE_SPEED
