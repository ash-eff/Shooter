extends State

func enter(_msg := {}) -> void:
	owner.animation_player.play("Transform")
	
func next_animation():
	print("Transform: ", owner.current_tape)
	match owner.current_tape:
		"Judge Dredd":
			state_machine.transition_to("Idle")
		"Robocop":
			state_machine.transition_to("IdleRobocop")
