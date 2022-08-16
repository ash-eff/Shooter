extends Area2D

export (int) var value = 2
export (float) var collect_radius = 20.0
export (float) var move_speed = 150.0
var target = null

onready var collect_area = $CollisionShape2D

func _ready():
	set_radius_size()
	
func _process(delta: float) -> void:
	if target == null:
		return
	position = position.move_toward(target.global_position, delta * move_speed)
	
func set_radius_size():
	collect_area.shape.radius = collect_radius

func _on_XP_body_entered(body: Node) -> void:
	target = body

func _on_Pickup_body_entered(body: Node) -> void:
	body.get_node("XPManager").collect_xp(value)
	queue_free()
