extends KinematicBody2D

export (int) var health = 50
export (float) var move_speed = 30.0
var knockback_position
var knockback_time
var lerp_time = 1
var current_lerp_time = 1
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var muzzle_rotator = $MuzzleRotator
onready var muzzle = $MuzzleRotator/Muzzle
onready var collision = $CollisionShape2D

var dir = Vector2.ZERO
var target: Player = null

func _ready() -> void:
	target = get_parent().get_node("Player")

func take_damage(damage, is_crit):
	health -= damage
	$FCTManager.show_value(damage, is_crit)
	knock_back()
	if health <= 0:
		die()

		
func knock_back():
	if knockback_time <= 0:
		return
	$StateMachine.transition_to("Knockback")
		
func die():
	pass
