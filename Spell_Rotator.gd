extends Node2D

export (PackedScene) var Spell

onready var rotator = $Rotator
var number_of_spells = 0
var spells = []
var radius = Vector2(48, 0)
var center = Vector2(0, 0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("item_0"):
		clear_spells()
		number_of_spells += 1
		cast_spell()
		
	if Input.is_action_just_pressed("item_1"):
		clear_spells()
		number_of_spells -= 1
		if number_of_spells < 1:
			number_of_spells = 0
			return
		cast_spell()
		
func clear_spells():
	for s in spells:
		s.queue_free()
	spells.clear()

func cast_spell():
	var step = 2 * PI / number_of_spells
	for i in range(number_of_spells):
		var spawn_pos = center + radius.rotated(step * i)
		var node = Spell.instance()
		spells.append(node)
		node.global_position = spawn_pos
		rotator.add_child(node)
