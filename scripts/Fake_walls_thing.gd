extends Area2D
@onready var tilemap = $"../../TileMap"
@onready var michael = $"../MichaelLooking"
var has_entered = 0

func _on_body_entered(body):
	if !has_entered:
		tilemap.set_layer_modulate(3, Color(1, 1, 1, 0))
		has_entered = 1
		michael.visible = true
	else:
		has_entered = 0
		michael.visible = false
		tilemap.set_layer_modulate(3, Color(1, 1, 1, 1))
		
