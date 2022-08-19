extends Area2D

signal damage_taken(amount, is_crit)


func _on_EnemyHurtbox_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("Projectile"):
		area.owner.queue_free()
		emit_signal("damage_taken", area.get_damage(), area.get_if_crit())
