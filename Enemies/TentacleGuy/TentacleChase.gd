extends State

var point = Vector2.ZERO
var direction
var path := PoolVector2Array() setget set_path

func enter(_msg := {}) -> void:
	print("Chase")
	owner.animation_player.play("Chase")
	#owner.chase_range.set_disabled(false)

func handle_input(_event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	point = owner.target.global_position
	path = get_tree().root.get_child(1).get_safe_path(owner.global_position, point)
	if owner.dir.x >= 0:
		owner.sprite.flip_h = false
	else:
		owner.sprite.flip_h = true
	if path.size() > 0:
		var move_distance = owner.move_speed * delta
		move_along_path(move_distance)
	elif path.size() == 0:
		state_machine.transition_to("Idle")

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
		elif distance < 0.0:
			owner.position = path[0]
			print("done")
			state_machine.transition_to("Idle")
			break
		distance -= distance_to_next
		starting_point = path[0]
		path.remove(0)
		
func set_path(value : PoolVector2Array) -> void:
	path = value


#func _on_Range_body_entered(body: Node) -> void:
	#if body.name == "Player":
		#path.empty()
		#owner.chase_range.set_disabled(true)
		#state_machine.transition_to("Shoot")
