extends StaticBody2D
@onready var player_penguin = get_node("/root/World/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_slide_entered(body):
	player_penguin.is_sliding = true


func _on_slide_exited(body):
	player_penguin.is_sliding = false
