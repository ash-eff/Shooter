class_name Damage
extends Area2D

export var base_damage = 10
export var can_crit = true
export var dot_ticks := 0
export var health = 1 #88 means it's infinite and can't be destroyed 
export var damage_type : String
var is_dot = false
var is_crit = false

func _init() -> void:
	collision_layer = 4
	collision_mask = 0

func get_if_crit():
	return is_crit
	
func get_if_dot():
	return is_dot
	
func get_damage():
	check_crit()
	check_dot()
	var dmg = round(base_damage + (base_damage * GameManager.player_stats.bullet_damage_percent))
	if is_crit:
		dmg += base_damage * 2
	if is_dot:
		dmg += base_damage
	return dmg
	
func get_damage_type():
	return damage_type
	
func get_dot_ticks():
	return dot_ticks
	
func check_dot():
	is_dot = false
	var randomNumber = rand_range(0,1)
	if randomNumber <= 0.1:
		is_dot = true
	
func check_crit():
	if not can_crit:
		return false
	var randomNumber = rand_range(0,1)
	if randomNumber <= GameManager.player_stats.crit_chance:
		is_crit = true

func check_health():
	if health == 88:
		return
	health -= 1
	if health <= 0:
		get_parent().queue_free()
