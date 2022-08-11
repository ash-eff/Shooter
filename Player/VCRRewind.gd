extends State

func enter(_msg := {}) -> void:
	pass
	 
func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if owner.touching_tape != null:
		if Input.is_action_just_pressed("interact"):
			owner.add_tape_to_collection(owner.touching_tape)
			connect("pickup_tape", owner.touching_tape, "on_picked_up")
			emit_signal("pickup_tape")
			owner.touching_tape = null

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
