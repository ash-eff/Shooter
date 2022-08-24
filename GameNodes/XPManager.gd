extends Node2D

signal level_up(level)
signal gain_xp(amount)
signal set_required_experience(value)

var level = 1
var experience = 0
var experience_total = 0
var experience_required = 0

func _ready() -> void:
	experience_required = get_required_experience(level + 1)

func collect_xp(value):
	experience_total += value
	experience += value
	emit_signal("gain_xp", experience)
	if experience >= experience_required:
		level_up()

func get_required_experience(lev):
	var req = round(pow(lev, 1.8) + lev * 4 + 10)
	print("XP Required: ", req)
	emit_signal("set_required_experience", req)
	return req
	
func level_up():
	var carry_over = experience - experience_required
	experience = carry_over
	level += 1
	experience_required = get_required_experience(level + 1)
	emit_signal("gain_xp", experience)
	emit_signal("level_up", level)
