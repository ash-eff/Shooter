extends KinematicBody2D

func _on_EnemyHurtbox_damage_taken(amount, is_crit) -> void:
	$FCTManager.show_value(amount, is_crit)
	$UnitSprite.flash_sprite() 
