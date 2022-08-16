extends Area2D

export var minimum_damage = 1
export var maximum_damage = 3
export var can_crit = true
export var crit_chance = 0.2
export var knockback_duration = 0
export var health = 1 #88 means it's infinite and can't be destroyed 
var is_crit = false
var actual_damage

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dmg = rng.randi_range(minimum_damage, maximum_damage)
	actual_damage = dmg
	
func get_if_crit():
	return is_crit
	
func check_crit():
	#calculate crit here from player stats
	if not can_crit:
		return false
	var randomNumber = rand_range(0,1)
	if randomNumber <= crit_chance:
		is_crit = true

func get_damage():
	# calculate damage here from player stats
	check_crit()
	var dmg = actual_damage
	if is_crit:
		dmg = actual_damage * 2
	return dmg

func check_health():
	if health == 88:
		return
	health -= 1
	if health <= 0:
		get_parent().queue_free()

func _on_ProjectileDamage_area_entered(area: Area2D) -> void:
	check_health()
