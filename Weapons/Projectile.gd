extends Node2D

export var speed = 600
var velocity = Vector2()

func _physics_process(delta):
	position += velocity * speed * delta
