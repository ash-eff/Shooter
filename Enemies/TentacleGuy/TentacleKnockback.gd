extends State

var point = Vector2.ZERO
var direction
var path := PoolVector2Array() setget set_path

func enter(_msg := {}) -> void:
	print("Knockback")
	$Timer.wait_time = owner.knockback_time
	$Timer.start()
	owner.animation_player.play("Knockback")

func handle_input(_event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	point = owner.knockback_position
	path = get_tree().root.get_child(0).get_safe_path(owner.global_position, point)
	if owner.dir.x >= 0:
		owner.sprite.flip_h = false
	else:
		owner.sprite.flip_h = true
	if path.size() > 0:
		var move_distance = owner.move_speed * delta
		move_along_path(move_distance)

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func move_along_path(distance : float) -> void:
	var starting_point = owner.position 
	for i in range(path.size()):
		var distance_to_next = starting_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			owner.position = starting_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		distance -= distance_to_next
		starting_point = path[0]
		path.remove(0)
		
func set_path(value : PoolVector2Array) -> void:
	path = value


func _on_Timer_timeout() -> void:
	state_machine.transition_to("Chase")
