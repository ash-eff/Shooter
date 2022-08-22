extends Node2D

signal damage_over_time(amount, is_crit, damage_type)

onready var timer = $Timer
onready var float_combat_text = $FCTManager
var dot_time := 2.0
var dot_ticks := 0
var damage_per_tick := 0
var this_owner = null


func start_damage_over_time(the_owner, damage, ticks):
	connect("damage_over_time", the_owner, "take_damage")
	this_owner = the_owner
	damage_per_tick = round(damage / ticks)
	dot_ticks = ticks - 1
	do_damage()
	timer.wait_time = dot_time / ticks
	timer.start()
	
func do_damage():
	emit_signal("damage_over_time", damage_per_tick, false, null)
	#$FCTManager.show_value(damage_per_tick, false)
	#print(this_owner)
	#this_owner.get_node("UnitSprite").flash_sprite()

func _on_Timer_timeout() -> void:
	if dot_ticks == 0:
		queue_free()
		return
	dot_ticks -= 1
	do_damage()
	timer.start()
