extends KinematicBody2D

func _on_Hurtbox_take_damage(damage, is_crit) -> void:
	$FCTManager.show_value(damage, is_crit)
