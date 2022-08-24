class_name PlayerHitbox
extends Area2D

func _init() -> void:
	collision_layer = 4
	collision_mask = 1

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(area: Area2D) -> void:
	print(area)
