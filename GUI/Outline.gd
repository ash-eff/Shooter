extends TextureRect

export(Color, RGB) var play_color
export(Color, RGB) var rewind_color

func play():
	$AnimationPlayer.play("Play")
	modulate = play_color
	
func rewind():
	$AnimationPlayer.play("Rewind")
	modulate = rewind_color
