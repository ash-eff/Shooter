extends TextureRect

export (Texture) var texture_color
export (Texture) var texture_BW
onready var key_label = $KeyLabel
onready var sweep = $Sweep
onready var outline = $Outline
export var run = 5.0
export var cooldown = 10.0
export var ability_key = 0

func _ready():
	key_label.text = str(ability_key)
	texture = texture_color
	sweep.texture_progress = texture_BW
	sweep.value = 0
	
func activate():
	deselect_item()
	key_label.hide()
	outline.play()
	outline.visible = true
	
func select_item():
	$Selection.visible = true
	
func deselect_item():
	$Selection.visible = false
