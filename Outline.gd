extends TextureRect

func play():
	$AnimationPlayer.play("Play")
	
func rewind():
	$AnimationPlayer.play("Rewind")
