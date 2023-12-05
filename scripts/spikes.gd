extends Area2D
@onready var player_penguin = get_node("/root/World/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_(delta):
	pass


func _on_spike_entered(_body):
	player_penguin.has_to_awaken = true
	player_penguin.respawn()


func undertalecospaly(body):
	pass # Replace with function body.


func undertalecosplay(body):
	pass # Replace with function body.
