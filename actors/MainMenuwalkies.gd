extends ParallaxBackground

var speed = -60

var direction = Vector2(1, 0)

@onready var parallax = $ParallaxBackground

func _process(delta):
	scroll_offset += direction * speed * delta
