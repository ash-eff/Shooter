class_name EnemyHurtbox
extends Area2D

signal hit
signal damage_taken(amount, is_crit, damage_type)
signal damage_over_time(amount, dot_ticks)

func _init() -> void:
	collision_layer = 0
	collision_mask = 4
	
func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Damage"):
		var damage = area.get_damage()
		var crit = area.get_if_crit()
		var dot = area.get_if_dot()
		if(dot):
			emit_signal("damage_over_time", damage, area.get_dot_ticks())
		else:
			emit_signal("damage_taken", damage, crit, area.get_damage_type())
		area.check_health()
		emit_signal("hit")
