extends Node2D

signal tape_aquired(tape)
signal swap_tape_index(index)
signal swap_tape(tape)
signal play_tape(tape)
signal play_stopped
signal rewind_tape(tape)

var tapes_dictionary = {}
var weapons = []
var touching_tape = null
var current_tape
var current_weapon = null
export var weapon_index = 0
var selected_weapon_index = -1

func add_tape_to_collection(tape):
	var weapon = tape.vhs_tape.Weapon.instance()
	get_parent().add_child(weapon)
	weapons.append(weapon)
	tapes_dictionary[weapon] = tape.vhs_tape
	emit_signal("tape_aquired", tape)
	if weapons.size() == 1:
		swap_tape()
		selected_weapon_index = 0
		swap_weapon()
	
func swap_tape():
	if weapons.size() < 1:
		return
	if weapon_index + 1 > weapons.size():
		return
	current_tape = tapes_dictionary[weapons[weapon_index]]
	emit_signal("swap_tape_index", weapon_index)
	emit_signal("swap_tape", current_tape.tape_name)
	
func play_tape():
	emit_signal("play_tape", current_tape)
	
func swap_weapon():
	if current_weapon != null:
		current_weapon.deactivate_gun()
	current_weapon = weapons[weapon_index]
	current_weapon.activate_gun()
	
func _on_tape_play_complete():
	emit_signal("rewind_tape", current_tape)
	weapon_index = 0
	selected_weapon_index = 0
	swap_tape()
	swap_weapon()
	emit_signal("play_stopped")
	$StateMachine.transition_to("Rewind")
	
func _on_tape_rewind_complete():
	$StateMachine.transition_to("Stop")

func _on_VCR_area_entered(area: Area2D) -> void:
	if area.is_in_group("tape"):
		touching_tape = area

func _on_VCR_area_exited(area: Area2D) -> void:
	if area.is_in_group("tape"):
		touching_tape = null
