extends RayCast2D

var target: Player = null

func _process(delta: float) -> void:
	set_cast_to(get_parent().dir * 800.0)
	if is_colliding():
		if get_collider() is Player:
			target = get_collider()
			pass
			#print(target)
