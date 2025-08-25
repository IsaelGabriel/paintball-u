extends CharacterBody3D

class_name Player

const GRAVITY = 15
const SPEED = 10
const SLIDE_SPEED = 40
const JUMP_FORCE = 15
const MOVEMENT_JUMP_FORCE = 3
const STOMP_FORCE = 40
const JUMP_STEER_FACTOR = 0.5
const SLIDE_STEER = 20

# Buffer
const JUMP_BUFFER = 0.15

var jump_buffer_count = 0.0

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
	
	
	var movement_input = Input.get_vector("p_left", "p_right", "p_forward", "p_back").normalized().rotated(-rotation.y)
	
	if jump_buffer_count > 0.0:
		jump_buffer_count -= delta
	
	if is_on_floor():
		
		if not sliding:
			velocity.x = movement_input.x * SPEED
			velocity.z = movement_input.y * SPEED
		if jump_buffer_count > 0.0:
			velocity.y = JUMP_FORCE
			sliding = false
			velocity.x += movement_input.x * MOVEMENT_JUMP_FORCE
			velocity.z += movement_input.y * MOVEMENT_JUMP_FORCE
		elif Input.is_action_pressed("p_slide") and not movement_input.is_zero_approx():
			if not sliding:
				slide_direction = movement_input
			sliding = true
			
	else:
		if Input.is_action_just_pressed("p_slide"):
			velocity.y = -STOMP_FORCE
			velocity.x = 0
			velocity.z = 0
		
	if sliding:
		var desired_velocity: Vector2 = slide_direction * SLIDE_SPEED
		var horizontal_velocity: Vector2 = Vector2(velocity.x, velocity.z)
		var velocity_difference = desired_velocity - horizontal_velocity
		if horizontal_velocity.length() <= SLIDE_SPEED or horizontal_velocity.normalized() != slide_direction.normalized():
			velocity.z = slide_direction.y * SLIDE_SPEED
			velocity.x = slide_direction.x * SLIDE_SPEED
		if not velocity_difference.is_zero_approx():
			velocity.z += velocity_difference.y * SLIDE_STEER * delta
			velocity.x += velocity_difference.x * SLIDE_STEER * delta
			
	if Input.is_action_just_pressed("p_jump"):
		jump_buffer_count = JUMP_BUFFER
	
			
