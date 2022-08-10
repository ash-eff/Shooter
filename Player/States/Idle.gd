extends State

func enter(_msg := {}) -> void:
	owner.animation_player.play("Idle")
	owner.velocity = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("right") or Input.is_action_pressed("left")  or Input.is_action_pressed("down") or Input.is_action_pressed("up"):
		state_machine.transition_to("Run")
