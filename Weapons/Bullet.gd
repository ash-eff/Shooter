extends Area2D

export var damage = 1
export var speed = 600
var velocity = Vector2()

func _physics_process(_delta):
	position += velocity * speed


func _on_Bullet_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
	queue_free()
