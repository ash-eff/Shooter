extends State

func enter(_msg := {}) -> void:
	$Timer.wait_time = owner.knockback_time
	$Timer.start()
	owner.animation_player.play("Knockback")

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	var velocity = owner.dir_to_target * owner.move_speed
	velocity = owner.move_and_slide(-velocity)

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func _on_Timer_timeout() -> void:
	if owner.health <= 0:
		state_machine.transition_to("Dead")
	else:
		state_machine.transition_to("Chase")
