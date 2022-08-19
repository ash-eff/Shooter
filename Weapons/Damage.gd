extends Area2D

export var base_damage = 10
export var can_crit = true
export var health = 1 #88 means it's infinite and can't be destroyed 
enum damage_type {default, fire, ice, curse}
export (damage_type) var selected_damage_type = damage_type.default
var is_crit = false

func get_if_crit():
	return is_crit
	
func check_crit():
	if not can_crit:
		return false
	var randomNumber = rand_range(0,1)
	if randomNumber <= GameManager.player.player_crit_chance:
		is_crit = true

func get_damage():
	check_crit()
	var dmg = round(base_damage + (base_damage * GameManager.player.player_bullet_damage_percent))
	if is_crit:
		dmg = base_damage * 2
	return dmg
	
func get_damage_type():
	return selected_damage_type

func check_health():
	if health == 88:
		return
	health -= 1
	if health <= 0:
		get_parent().queue_free()
