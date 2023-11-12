extends Area2D
@onready var player_penguin = get_node("/root/World/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spike_entered(body):
	player_penguin.can_has_death = true
	# player_penguin.bonk()
	player_penguin.respawn()
