extends State

var velocity = Vector2.ZERO
var path = []
var threshold = 4
var world = null

func enter(_msg := {}) -> void:
	owner.animation_player.play("Chase")
	world = owner.owner

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if path.size() > 0:
		move_along_path()
	owner.face_player(true)

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass

func move_along_path() -> void:
	if owner.global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = owner.global_position.direction_to(path[0])
		velocity = direction * owner.move_speed
		velocity = owner.move_and_slide(velocity)
		
func get_target_path():
	path = world.get_safe_path(owner.global_position, owner.target.global_position)


func _on_Timer_timeout() -> void:
	get_target_path()
