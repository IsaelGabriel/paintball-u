extends Node

class_name Damageable

signal damaged(source: Node, value: int)
signal killed(source: Node)
signal healed(source: Node, value: int)

@export var max_hp: int = 1

var hp: float

func _ready() -> void:
	hp = max_hp

func deal_damage(source: Node, value: float) -> void:
	if(hp <= 0 or value <= 0): return
	hp -= value
	damaged.emit(source, value)
	if(hp <= 0):
		hp = 0
		killed.emit(source)
		
func deal_healing(source: Node, value: float) -> void:
	if(hp == max_hp or value <= 0): return
	hp = min(hp + value, max_hp)
	healed.emit(source, value)
	
	
