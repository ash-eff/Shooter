extends "res://Enemies/Enemy.gd"

func _process(delta: float) -> void:
	dir = (target.global_position - global_position).normalized()

func reset_to_idle():
	$StateMachine.transition_to("Idle")

func die():
	$StateMachine.transition_to("Dead")

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	#flash sprite
	var dir = (global_position - area.global_position).normalized()
	knockback_position = global_position + (dir * 15)
	knockback_time = area.knockback_time
	var crit = area.get_if_crit()
	var damage = area.get_damage()
	take_damage(damage, crit)
