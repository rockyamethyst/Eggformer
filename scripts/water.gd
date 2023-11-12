extends Area2D
@onready var player = get_node("/root/World/player")


func STOP_SWIMMING(body):
	player.can_has_death = true
	player.respawn()
