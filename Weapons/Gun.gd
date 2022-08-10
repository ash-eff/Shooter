extends Node2D

export (float) var max_recoil := 10.0
var current_recoil := 0.0
var mouse_position = Vector2()

export (PackedScene) var Bullet

onready var sprite = $Sprite
onready var muzzle = $Muzzle
onready var cooldown = $Cooldown
onready var animation_player = $AnimationPlayer

func _ready() -> void:
	deactivate_gun()

func _process(_delta: float) -> void:
	rotate_gun()
	change_gun_z_axis()
	flip_sprite()
	
func _physics_process(_delta: float) -> void:
	if not Input.is_action_pressed("Shoot"):
		var recoil_increment = max_recoil * 0.05
		current_recoil = clamp(current_recoil - recoil_increment, 0.0, max_recoil)
	
	if Input.is_action_pressed("Shoot"):
		shoot()
	
func shoot():
	print("shoot")

func rotate_gun():
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
func change_gun_z_axis():
	var gun_degrees = global_rotation_degrees
	if gun_degrees <= -40.0 && gun_degrees >= -140.0:
		z_index = -1
	else:
		z_index = 0

func flip_sprite():
	var dir = mouse_position - global_position
	if dir.x >=0:
		sprite.flip_v = false
	else:
		sprite.flip_v = true

func reset_weapon():
	animation_player.play("Idle")
	
func activate_gun():
	self.visible = true
	set_physics_process(true)
	
func deactivate_gun():
	self.visible = false
	set_physics_process(false)
