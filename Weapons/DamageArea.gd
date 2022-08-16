extends Area2D

export var damage = 1
export var can_crit = true
export var knockback_time = .15
export var health = 1 #88 means it's infinite and can't be destroyed 
var is_crit = false
	
func get_if_crit():
	#calculate crit here from player stats
	if not can_crit:
		return false
	var randomNumber = rand_range(0,1)
	if randomNumber <= 0.2:
		is_crit = true
	return is_crit

func get_damage():
	# calculate damage here from player stats
	var actual_dmg = damage
	if is_crit:
		actual_dmg = damage * 2
	return actual_dmg

func check_health():
	if health == 88:
		return
	health -= 1
	if health <= 0:
		get_parent().queue_free()

func _on_DamageArea_area_entered(area: Area2D) -> void:
	check_health()
