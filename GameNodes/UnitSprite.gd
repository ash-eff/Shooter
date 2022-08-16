extends Sprite

export (Color) var normal_color
export (Color) var flash_color
onready var flash_timer = $Timer

func _on_Timer_timeout() -> void:
	modulate = normal_color

func _on_flash_sprite() -> void:
	modulate = flash_color
	flash_timer.start()
