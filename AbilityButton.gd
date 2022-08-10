extends TextureRect

export (Texture) var texture_color
export (Texture) var texture_BW
onready var time_label = $Counter/Value
onready var run_timer = $RunTimer
onready var cooldown_timer = $CooldownTimer
onready var sweep = $Sweep
onready var outline = $Outline
export var run = 5.0
export var cooldown = 10.0
var is_running = false
var is_cooling_down = false

func _ready():
	cooldown_timer.wait_time = cooldown
	run_timer.wait_time = run
	time_label.hide()
	sweep.texture_progress = texture
	sweep.value = 0
	set_process(false)
	
func _process(delta):
	if cooldown == 0:
		return
	if is_running:
		pass
		time_label.text = "%3.1f" % run_timer.time_left
	if is_cooling_down:
		time_label.text = "%3.1f" % cooldown_timer.time_left
		sweep.value = int((cooldown_timer.time_left / cooldown) * 100)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("item_0"):
		if is_running || is_cooling_down:
			return
		select_item()
	if Input.is_action_just_pressed("item_1"):
		if is_running || is_cooling_down:
			return
		deselect_item()
	if Input.is_action_just_pressed("rmb"):
		if is_running || is_cooling_down:
			return
		deselect_item()
		outline.play()
		outline.visible = true
		is_running = true
		set_process(true)
		run_timer.start()
		time_label.show()
		
func select_item():
	$Selection.visible = true
	
func deselect_item():
	$Selection.visible = false

func _on_RunTimer_timeout() -> void:
	sweep.texture_progress = texture_BW
	outline.rewind()
	is_running = false
	is_cooling_down = true
	cooldown_timer.start()

func _on_CooldownTimer_timeout() -> void:
	texture = texture_color
	print("ability ready")
	sweep.value = 0
	outline.visible = false
	time_label.hide()
	is_cooling_down = false
	set_process(false)	
