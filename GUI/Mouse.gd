extends Sprite

var target = load("res://Art/cursor_target.png")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	texture = target
	
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
