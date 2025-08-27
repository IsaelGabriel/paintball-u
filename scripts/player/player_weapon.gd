extends Node3D

class_name PlayerWeapon

const RAY_LENGTH = 1000

var damage = 2
var cooldown = .3
var cooldown_count = 0.0

@export var ray_bullet: PackedScene
@export var splatter: PackedScene

func _process(delta: float) -> void:
	if cooldown_count > 0:
		cooldown_count -= delta
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("p_shoot") and cooldown_count <= 0:
		cooldown_count = cooldown
		
		# Shoot with raycast
		var space_state = get_world_3d().direct_space_state
		var end = global_position + (-global_transform.basis.z) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(global_position, end)
		query.collide_with_bodies = true
		query.exclude = [get_parent().get_parent()]
		
		#var raycast_obj = RayCast3D.new()
		#raycast_obj.position = global_position
		#raycast_obj.target_position = end
		#get_tree().current_scene.add_child(raycast_obj)
		var new_splatter: Node3D = null
		var hit: Dictionary = space_state.intersect_ray(query)
		if not hit.is_empty():
			end = hit["position"]
			if hit["collider"].is_in_group("Damageable"):
				for child in hit["collider"].get_children():
					if child is Damageable:
						child.deal_damage(get_parent().get_parent(), damage)
			# Create splatter
			new_splatter = splatter.instantiate()
			new_splatter.visible = false
			new_splatter.look_at(hit["normal"])
			print(hit["normal"])
			hit["collider"].add_child(new_splatter)
			new_splatter.global_position = hit["position"]
		
		var bullet: RayBulletTrail = ray_bullet.instantiate()
		bullet.position = global_position
		bullet.start = global_position
		bullet.direction = (end - global_position).normalized()
		bullet.end = end
		bullet.splatter = new_splatter
		get_tree().current_scene.add_child(bullet)
		
