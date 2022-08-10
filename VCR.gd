extends Node2D

var tapes_dictionary = {}
var weapons = []
var touching_tape = null
var current_tape
var current_weapon = null
var weapon_index = 0
var selected_weapon_index = -1

func add_tape_to_collection(tape):
	var weapon = tape.vhs_tape.Weapon.instance()
	get_parent().add_child(weapon)
	weapons.append(weapon)
	tapes_dictionary[weapon] = tape.vhs_tape 
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
	print(current_tape.tape_name)
	# adjust ui here and load tape to be played
	
func swap_weapon():
	if current_weapon != null:
		current_weapon.deactivate_gun()
	current_weapon = weapons[weapon_index]
	current_weapon.activate_gun()

func _on_VCR_area_entered(area: Area2D) -> void:
	if area.is_in_group("tape"):
		touching_tape = area

func _on_VCR_area_exited(area: Area2D) -> void:
	if area.is_in_group("tape"):
		touching_tape = null
