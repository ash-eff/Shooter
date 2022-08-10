extends State

func enter(_msg := {}) -> void:
	print("VCR Rewinding ", owner.current_tape.tape_name)
	$Timer.wait_time = owner.current_tape.rewind_time
	$Timer.start()
	owner.weapon_index = 0
	owner.swap_weapon()
	 
func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if owner.touching_tape != null:
		if Input.is_action_just_pressed("interact"):
			owner.add_tape_to_collection(owner.touching_tape)
			connect("pickup_tape", owner.touching_tape, "on_picked_up")
			emit_signal("pickup_tape")
			owner.touching_tape = null
	print(int(round($Timer.time_left)))

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func _on_Timer_timeout() -> void:
	state_machine.transition_to("Stop")
