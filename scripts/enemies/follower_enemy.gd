class_name FollowerEnemy extends CharacterBody3D

const GRAVITY = 15
const SPEED = 8
const STEER_SPEED = 5
const TARGET_TRESHOLD = 2

@onready var player: Player = get_tree().current_scene.get_node("Player")
var target_position: Vector3

func _ready() -> void:
	target_position = Vector3(player.position.x, position.y, player.position.z)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	var true_target = Vector3(player.position.x, position.y, player.position.z)
	
	target_position += (true_target - target_position).normalized() * delta * STEER_SPEED
	look_at(target_position)
	
	if is_on_floor():
		velocity = -transform.basis.z * SPEED
	
	move_and_slide()


func _on_damageable_killed(source: Node) -> void:
	queue_free()
