extends KinematicBody2D

export (PackedScene) var xp
export (int) var health = 50
export (float) var move_speed = 30.0
var knockback_position
var knockback_time = 0
var lerp_time = 1
var current_lerp_time = 1
onready var animation_player = $AnimationPlayer
onready var sprite = $UnitSprite
onready var collision = $CollisionShape2D
onready var hurtbox = $Hurtbox


var dir = Vector2.ZERO
var target: Player = null

func _ready() -> void:
	target = get_parent().get_node("Player")

func take_damage(damage, is_crit):
	if $StateMachine.get_current_state_name() == "Dead":
		return
	health -= damage
	$FCTManager.show_value(damage, is_crit)
	if health <= 0:
		die()
		spawn_xp()
		
			
func knock_back(direction, duration):
	#calculate knockback reistance
	knockback_time = duration
	if knockback_time <= 0:
		return
	knockback_position = global_position + (direction * 100)
	$StateMachine.transition_to("Knockback")
		
func die():
	pass
	
func spawn_xp():
	var experience = xp.instance()
	get_parent().call_deferred("add_child", experience)
	experience.transform = global_transform
