extends Control

class_name Transitioner

@export var scene_switch : String = "fade_out"
@export var scene_to_load : PackedScene
@onready var animation : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer
var is_faded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_next_animation(fading_out : bool):
	if(!is_faded):
		if(fading_out):
			animation_player.play("fade_out")
			is_faded = false
			print_debug(scene_to_load)
		else:
			animation_player.play("fade_in")
			is_faded = true

func _on_animation_player_animation_finished(anim_name):
	if(scene_to_load != null && anim_name == scene_switch):
		get_tree().change_scene_to_packed(scene_to_load)
		is_faded = false
