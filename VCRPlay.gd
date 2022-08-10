extends State

func enter(_msg := {}) -> void:
	print("VCR Playing ", owner.current_tape.tape_name)
	$Timer.wait_time = owner.current_tape.run_time
	$Timer.start()
	owner.swap_weapon()

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	print(int(round($Timer.time_left)))

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func _on_Timer_timeout() -> void:
	state_machine.transition_to("Rewind")
