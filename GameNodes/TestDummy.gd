extends KinematicBody2D

export (PackedScene) var dot_scene;

func take_damage(damage, is_crit, damage_type, is_dot, dot_ticks):
	#if $StateMachine.get_current_state_name() == "Dead":
		#return
	$UnitSprite.flash_sprite()
	if is_dot:
		var dot = dot_scene.instance() 
		add_child(dot)
		dot.start_damage_over_time(self, damage, dot_ticks)
		return
	$FCTManager.show_value(damage, is_crit)

func _on_EnemyHurtbox_damage_taken(amount, is_crit, damage_type, is_dot, dot_ticks) -> void:
	take_damage(amount, is_crit, damage_type, is_dot, dot_ticks)
	
