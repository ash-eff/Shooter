extends Node2D

var player = null
var player_stats = null

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	player_stats = player.player_stats
	print(player_stats.player_name) 
