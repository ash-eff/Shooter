extends "res://Enemies/Enemy.gd"

func _process(delta: float) -> void:
	dir = (target.global_position - global_position).normalized()

func reset_to_idle():
	$StateMachine.transition_to("Idle")

func die():
	$StateMachine.transition_to("Dead")

func _on_Hurtbox_take_damage(damage, is_crit) -> void:
	take_damage(damage, is_crit)

func _on_Hurtbox_knockback(from_dir, duration) -> void:
	knock_back(from_dir, duration)
