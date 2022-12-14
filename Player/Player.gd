extends KinematicBody2D
 
class_name Player

export (int) var speed = 125

var velocity = Vector2()
var mouse_position = Vector2()
var current_tape
onready var player_sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var bullet = preload("res://Weapons/Bullet.tscn")
	
func _physics_process(_delta):
	set_mouse_position()
	flip_sprite()
	velocity = move_and_slide(velocity)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func end_transformation():
	$StateMachine.transition_to("Idle")
	
func set_mouse_position():
	mouse_position = get_local_mouse_position()
	
func flip_sprite():
	if mouse_position.x >=0:
		player_sprite.flip_h = false
	else:
		player_sprite.flip_h = true

func _on_VCR_play_tape(tape) -> void:
	print("Playing: ", current_tape)
	$StateMachine.transition_to("Transform")

func _on_VCR_rewind_tape(tape) -> void:
	print("Rewinding: ", current_tape)
	
func _on_VCR_swap_tape(tape) -> void:
	current_tape = tape

func _on_VCR_play_stopped() -> void:
	$StateMachine.transition_to("Transform")
