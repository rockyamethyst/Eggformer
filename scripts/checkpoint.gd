extends Node2D

@onready var red_flag = $Area2D/Red_flag
@onready var blue_flag = $Area2D/BlueFlag
@onready var recruta = get_node("/root/World/player")

func _on_checkpoint_touched(_body):
		recruta.checkpoint_pos = global_position
# print_debug("POS TIME: ", recruta.checkpoint_pos)
		recruta.has_checkpoint = true
		red_flag.visible = false
		blue_flag.visible = true
