extends State


func enter(_msg := {}) -> void:
	owner.chase_range.call_deferred("disabled", true)
	owner.animation_player.play("Die")
	owner.muzzle_rotator.visible = false
	owner.collision_shape.call_deferred("disabled", true)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
