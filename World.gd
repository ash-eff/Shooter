extends Node2D

onready var nav_2D : Navigation2D = $Navigation2D

func get_safe_path(from, to):
	var new_path := nav_2D.get_simple_path(from, to)
	return new_path
