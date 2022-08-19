extends State

func enter(_msg := {}) -> void:
	owner.animation_player.play("Idle")
	owner.velocity = Vector2.ZERO

func update(_delta: float) -> void:
	if Input.is_action_pressed("right") or Input.is_action_pressed("left")  or Input.is_action_pressed("down") or Input.is_action_pressed("up"):
		state_machine.transition_to("Move")
	if Input.is_action_just_pressed("Shoot"):
		owner.set_speed(owner.walk_speed)
	if Input.is_action_just_released("Shoot"):
		owner.set_speed(owner.run_speed)
