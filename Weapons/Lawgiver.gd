extends "res://Weapons/Gun.gd"

func shoot():
	if cooldown.is_stopped():
		cooldown.start()
		animation_player.play("Fire")
		#var recoil_degree_max = current_recoil * 0.5
		#var recoil_radians_actual = deg2rad(rand_range(-recoil_degree_max, recoil_degree_max))
		#var actual_bullet_direction = dir_to_mouse.rotated(recoil_radians_actual) 
		#var recoil_increment = max_recoil * 0.1
		#current_recoil = clamp(current_recoil + recoil_increment, 0.0, max_recoil)
		if number_of_shots == 1:
			var b = Bullet.instance()
			get_parent().owner.add_child(b)
			b.transform = muzzle.global_transform
			b.velocity = dir_to_mouse#actual_bullet_direction
		else:
			blast_shot()

func blast_shot():
	var shooting_angle = deg2rad(spread_angle)
	var angle_to = dir_to_mouse.angle()
	var half_spread_angle = shooting_angle / 2.0
	var starting_angle = angle_to - half_spread_angle
	var shot_offset = (number_of_shots - 1)
	var angle_offset = shooting_angle / shot_offset
	for i in number_of_shots:
		var new_dir = Vector2.RIGHT.rotated(starting_angle)
		var b = Bullet.instance()
		get_parent().owner.add_child(b)
		b.transform = muzzle.global_transform
		b.velocity = new_dir
		b.rotation = starting_angle
		starting_angle += (angle_offset)
	#reset_to_idle()
