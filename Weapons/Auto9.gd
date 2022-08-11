extends "res://Weapons/Gun.gd"

func shoot():
	if cooldown.is_stopped():
		cooldown.start()
		animation_player.play("Fire")
		var dir_to_mouse = (get_global_mouse_position() - global_position).normalized()
		var recoil_degree_max = current_recoil * 0.5
		var recoil_radians_actual = deg2rad(rand_range(-recoil_degree_max, recoil_degree_max))
		var actual_bullet_direction = dir_to_mouse.rotated(recoil_radians_actual) 
		var recoil_increment = max_recoil * 0.1
		current_recoil = clamp(current_recoil + recoil_increment, 0.0, max_recoil)
		var b = Bullet.instance()
		get_parent().owner.add_child(b)
		b.transform = muzzle.global_transform
		b.velocity = actual_bullet_direction
