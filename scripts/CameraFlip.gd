extends Area2D
@onready var recruta = get_node("/root/World/player")
var spawn_pos : Vector2 = position
@onready var wall = $Wall


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	



func do_a_flip():
	wall.position.x += 32 * recruta.LeftSideOfMap # i'm making this 32 pixels and calling it a day, need to fix other things
	wall.rotation_degrees = -180 * recruta.LeftSideOfMap



func _on_right_side_entered(body):
	if recruta.LeftSideOfMap:
		recruta.CameraFlip()
		do_a_flip()
	else:
		recruta.CameraFlip()
		do_a_flip()
