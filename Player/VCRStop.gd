extends State

signal pickup_tape

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
	if owner.weapons.size() > 1:
		if Input.is_action_just_pressed("item_0"):
			owner.weapon_index = 0
			if owner.weapon_index != owner.selected_weapon_index:
				owner.selected_weapon_index = owner.weapon_index
				owner.swap_tape()
		if Input.is_action_just_pressed("item_1"):
			owner.weapon_index = 1
			if owner.weapon_index != owner.selected_weapon_index:
				owner.selected_weapon_index = owner.weapon_index
				owner.swap_tape()
		if Input.is_action_just_pressed("item_2"):
			owner.weapon_index = 2
			if owner.weapon_index != owner.selected_weapon_index:
				owner.selected_weapon_index = owner.weapon_index
				owner.swap_tape()
		if owner.weapon_index > 0:
			if Input.is_action_just_pressed("rmb"):
				state_machine.transition_to("Play")


func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
