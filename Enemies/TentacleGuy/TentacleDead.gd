extends State

func enter(_msg := {}) -> void:
	owner.animation_player.play("Die")
	owner.collision.queue_free()
	owner.hurtbox.queue_free()

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
