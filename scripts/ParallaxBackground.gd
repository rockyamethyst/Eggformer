extends ParallaxBackground
var speed = -60
var direction = Vector2(1, 0)
func _process(delta):
	scroll_offset += direction * speed * delta
