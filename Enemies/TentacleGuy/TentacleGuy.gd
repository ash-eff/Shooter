extends "res://Enemies/Enemy.gd"

func _process(delta: float) -> void:
	dir = (target.global_position - global_position).normalized()

func reset_to_idle():
	$StateMachine.transition_to("Idle")

func die():
	$StateMachine.transition_to("Dead")

func _on_EnemyHurtbox_damage_taken(amount, is_crit, damage_type) -> void:
	take_damage(amount, is_crit, damage_type)
	$UnitSprite.flash_sprite()
	
func _on_EnemyHurtbox_damage_over_time(amount, dot_ticks) -> void:
	take_damage_over_time(amount, dot_ticks)
	$UnitSprite.flash_sprite()

func _on_EnemyHurtbox_hurtbox_hit() -> void:
	flash_sprite()

func _on_Hurtbox_knockback(from_dir, duration) -> void:
	knock_back(from_dir, duration)






