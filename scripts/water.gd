extends Area2D
@onready var player = get_node("/root/World/player")


func STOP_SWIMMING(body):
	player.has_to_awaken = true
	player.respawn()
