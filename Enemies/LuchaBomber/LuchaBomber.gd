extends "res://Enemy.gd"

export (PackedScene) var Bullet
export (int) var number_of_shots = 16
onready var gun = $OldPainless

func _process(delta: float) -> void:
	dir = (target.global_position - global_position).normalized()
	muzzle_rotator.look_at(target.global_position)	

func reset_to_idle():
	muzzle_rotator.visible = true
	$StateMachine.transition_to("Idle")
