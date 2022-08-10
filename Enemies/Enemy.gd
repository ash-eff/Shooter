extends KinematicBody2D

export (int) var health = 8
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var muzzle_rotator = $MuzzleRotator
onready var muzzle = $MuzzleRotator/Muzzle
onready var collision = $CollisionShape2D

var dir = Vector2.ZERO
var target: Player = null

func _ready() -> void:
	target = get_parent().get_node("Player")

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
		
func die():
	pass
