extends Area2D
@onready var recruta = get_node("/root/World/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func CameraFlipGaming(body):
		recruta.CameraFlip()



