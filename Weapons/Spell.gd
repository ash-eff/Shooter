extends Node2D

export var damage = 1

func _process(delta: float) -> void:
	var target = get_parent()
	look_at(target.global_position)
