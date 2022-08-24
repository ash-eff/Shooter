extends Node2D

export var damage = 1

func _process(_delta: float) -> void:
	var target = get_parent()
	look_at(target.global_position)
