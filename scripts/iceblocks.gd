extends StaticBody2D
@onready var player_penguin = get_node("/root/World/player")


func _on_slide_entered(_body):
		print_debug("YES!!!!!!!!")
		player_penguin.is_sliding += 1

func _on_slide_exited(_body):
		print_debug("NO!!!!!!!!!")
		player_penguin.is_sliding -= 1
