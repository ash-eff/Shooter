extends State

func enter(_msg := {}) -> void:
	$Timer.start()
	owner.animation_player.play("Idle")
	owner.muzzle_rotator.visible = false
	owner.collision.disabled = false
	
func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass
	#var distance = (owner.get_parent().get_node("Player").global_position - owner.global_position).length()
	#if distance <= 100:
		#state_machine.transition_to("Snipe")

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func _on_Timer_timeout() -> void:
	#check LOS
		# move to player if no LOS
	
	var randomNumber = rand_range(0,1)
	if randomNumber <= 0.5: # takes 1%
		state_machine.transition_to("Chase")
	else:
		state_machine.transition_to("Snipe")
