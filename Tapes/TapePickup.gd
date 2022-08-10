extends Area2D

export (Texture) var tape_graphic
export (Resource) var vhs_tape

func _ready() -> void:
	$Graphic.texture = tape_graphic
	$AnimationPlayer.play("Idle")
	
func _on_Tape_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		$Graphic.visible = true

func _on_Tape_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		$Graphic.visible = false

func on_picked_up():
	queue_free()
