extends "res://Enemies/Enemy.gd"

export (PackedScene) var Bullet
export (float) var spread_angle = 90.0
export (int) var number_of_shots = 6
var current_shot = 0
var rng = RandomNumberGenerator.new()

onready var chase_range = $ChaseRange/CollisionShape2D

func _process(delta: float) -> void:
	dir = (target.global_position - global_position).normalized()
	muzzle_rotator.look_at(target.global_position)	
	$RayCast2D.force_raycast_update()		
	
func fire_projectiles():
	blast_shot()

func reset_to_idle():
	current_shot = 0
	$StateMachine.transition_to("Idle")

func die():
	$StateMachine.transition_to("Dead")
	
func blast_shot():
	var shooting_angle = deg2rad(spread_angle)
	var angle_to = dir.angle()
	var half_spread_angle = shooting_angle / 2.0
	var starting_angle = angle_to - half_spread_angle
	var angle_offset = shooting_angle / (number_of_shots - 1)
	for i in number_of_shots:
		var new_dir = Vector2.RIGHT.rotated(starting_angle)
		var b = Bullet.instance()
		get_owner().add_child(b)
		b.transform = muzzle.global_transform
		b.velocity = new_dir
		b.rotation = starting_angle
		starting_angle += (angle_offset)
	reset_to_idle()

func sniper_shot():
	current_shot += 1
	var angle_to = dir.angle()
	var new_dir = Vector2.RIGHT.rotated(angle_to)
	var b = Bullet.instance()
	get_owner().add_child(b)
	b.transform = muzzle.global_transform
	b.velocity = new_dir
	b.rotation = angle_to
	if current_shot >= 6:
		reset_to_idle()
