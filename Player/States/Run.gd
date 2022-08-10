extends State

var velocity = Vector2()

func enter(_msg := {}) -> void:
	owner.animation_player.play("Run")

func update(_delta: float) -> void:
	check_velocity()

func _unhandled_input(event: InputEvent) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	owner.velocity = velocity.normalized() * owner.speed

func check_velocity():
	if velocity == Vector2.ZERO:
		state_machine.transition_to("Idle")
