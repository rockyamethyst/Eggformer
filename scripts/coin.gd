extends Area2D
@onready var texture := $anim as AnimatedSprite2D
@onready var recruta = get_node("/root/World/player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	texture.play("collect")
	


func _on_anim_animation_finished():
	recruta.coin_count += 1
	queue_free()
