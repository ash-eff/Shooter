extends State

var velocity = Vector2()

func enter(_msg := {}) -> void:
	if owner.current_speed == owner.run_speed:
		owner.animation_player.play("Run")
	else:
		owner.animation_player.play("Walk")

func update(_delta: float) -> void:
	check_velocity()
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	owner.velocity = velocity.normalized() * owner.current_speed
	if Input.is_action_just_pressed("Shoot"):
		owner.set_speed(owner.walk_speed)
		owner.animation_player.play("Walk")
	if Input.is_action_just_released("Shoot"):
		owner.set_speed(owner.run_speed)
		owner.animation_player.play("Run")

func check_velocity():
	if velocity == Vector2.ZERO:
		state_machine.transition_to("Idle")
