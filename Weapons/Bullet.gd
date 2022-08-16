extends Area2D

export var speed = 600
var velocity = Vector2()

func _physics_process(_delta):
	position += velocity * speed
