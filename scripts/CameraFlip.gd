extends Area2D
@onready var recruta = get_node("/root/World/player")
var spawn_pos : Vector2 = position
@onready var wall = $Wall


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	


func _on_right_side_entered(body):
	if !recruta.is_flippin:
		recruta.is_flippin = 1
		print_debug("why so serious")
	else:
		recruta.is_flippin = 0
		print_debug("ESTOU FICANDO LOUCO AAHAHAAAAAAAAHAHA")



func _on_right_side_left(body):
	wall.rotation_degrees += 180 # * recruta.LeftSideOfMap
	wall.position.x += 16 * recruta.LeftSideOfMap # i'm making this 32 pixels and calling it a day, need to fix other things
# this is stupidly jank, it blocks the player off if they try to bug the camera intentionally (or accidentally, if they try to do a quick turnaround, "wrong place" style.) BUT IT WILL DO. i DO NOT have brain power.





