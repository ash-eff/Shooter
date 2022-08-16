extends Control


func _on_XPManager_gain_xp(amount) -> void:
	$TextureProgress.value = amount


func _on_XPManager_level_up(level) -> void:
	$Label.text = "LEVEL " + str(level)


func _on_XPManager_set_required_experience(value) -> void:
	$TextureProgress.set_max(value)
	print($TextureProgress.get_max())
