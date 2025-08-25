extends CharacterBody3D

class_name DummyEnemy

@export var can_die: bool = false
@export_range(0.0, 10.0) var regen_time: float = 3.0
@export var regen_ammount: float

var regen_count: float = 0.0

@onready var damageable: Damageable = $Damageable

func _process(delta: float) -> void:
	if regen_count > 0:
		regen_count -= delta
		if regen_count <= 0:
			damageable.deal_healing(self, regen_ammount)
			if(damageable.hp < damageable.max_hp):
				regen_count = regen_time
			

func _on_damaged(source: Node, value: int) -> void:
	regen_count = regen_time
