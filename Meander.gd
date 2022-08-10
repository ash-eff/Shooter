extends State

var position = Vector2.ZERO
var velocity = Vector2()

func enter(_msg := {}) -> void:
	var dir = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	position = owner.global_position + dir
	owner.animation_player.play("Walk")
	velocity = owner.position.direction_to(position) * 75

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	velocity = owner.move_and_slide(velocity)

func exit() -> void:
	velocity = Vector2.ZERO
