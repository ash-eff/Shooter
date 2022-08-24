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

var dir = Vector2.ZERO
var target = null
var dir_to_target = Vector2.ZERO

func _ready() -> void:
	target = get_tree().get_nodes_in_group("player")[0]
	
func _process(_delta: float) -> void:
	dir = (target.global_position - global_position).normalized()

func face_player(is_facing):
	if not is_facing:
		return
	if dir.x >= 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
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
	if $StateMachine.get_current_state_name() == "Dead":
		return
	health -= damage
	if health <= 0:
		die()
		spawn_xp()
		
func flash_sprite():
	knock_back()
	$UnitSprite.flash_sprite()
			
func knock_back():
	if $StateMachine.get_current_state_name() == "Dead":
		return
	dir_to_target = global_position.direction_to(target.global_position)
	knockback_time = .15
	if knockback_time <= 0.0:
		return
	$StateMachine.transition_to("Knockback")
		
func die():
	$StateMachine.transition_to("Dead")
	
func spawn_xp():
	var experience = xp.instance()
	get_parent().call_deferred("add_child", experience)
	experience.transform = global_transform

func _on_EnemyHurtbox_damage_taken(amount, is_crit, damage_type) -> void:
	take_damage(amount, is_crit, damage_type)
	flash_sprite()
	
func _on_EnemyHurtbox_damage_over_time(amount, dot_ticks) -> void:
	take_damage_over_time(amount, dot_ticks)
	flash_sprite()

func _on_EnemyHurtbox_hit() -> void:
	knock_back()

