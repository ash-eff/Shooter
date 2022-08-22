extends KinematicBody2D

export (PackedScene) var dot_scene;
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
onready var hurtbox = $EnemyHurtbox


var dir = Vector2.ZERO
var target = null

func _ready() -> void:
	target = get_tree().get_nodes_in_group("player")[0]
	
func take_damage_over_time(damage, dot_ticks):
	if $StateMachine.get_current_state_name() == "Dead":
		return
	var dot = dot_scene.instance() 
	add_child(dot)
	dot.start_damage_over_time(self, damage, dot_ticks)

func take_damage(damage, is_crit, damage_type):
	if $StateMachine.get_current_state_name() == "Dead":
		return
	$FCTManager.show_value(damage, is_crit)
	lower_health(damage)
		
func lower_health(damage):
	health -= damage
	if health <= 0:
		die()
		spawn_xp()
		
func flash_sprite():
	$UnitSprite.flash_sprite()
			
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
