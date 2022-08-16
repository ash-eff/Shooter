extends Area2D

signal knockback(from_dir, duration)
signal flash_sprite
signal take_damage(damage, is_crit)

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	var dir = (global_position - area.global_position).normalized()
	emit_signal("knockback", dir, area.knockback_duration)
	emit_signal("flash_sprite")
	emit_signal("take_damage", area.get_damage(), area.get_if_crit())
