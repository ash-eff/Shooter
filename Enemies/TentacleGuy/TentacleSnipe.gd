extends State

func enter(_msg := {}) -> void:
	owner.animation_player.play("Snipe")
	owner.muzzle_rotator.visible = true
	
func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if owner.dir.x >= 0:
		owner.sprite.flip_h = false
	else:
		owner.sprite.flip_h = true

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
