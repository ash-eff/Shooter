extends "res://Enemies/Enemy.gd"

export (PackedScene) var explosion;

func explode():
	var e = explosion.instance()
	owner.add_child(e)
	e.transform = global_transform
	print(e)
	queue_free()
