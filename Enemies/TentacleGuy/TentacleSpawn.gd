extends State

func enter(_msg := {}) -> void:
	owner.sprite.visible = false
	owner.collision.disabled = true
	$Timer.start()
	owner.muzzle_rotator.visible = false
	
func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass


func _on_Timer_timeout() -> void:
	owner.sprite.visible = true
	if owner.dir.x >= 0:
		owner.sprite.flip_h = false
	else:
		owner.sprite.flip_h = true
	owner.animation_player.play("Spawn")
