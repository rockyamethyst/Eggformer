extends Control

@export var transitioner : Transitioner

# Called when the node enters the scene tree for the first time.
func _ready():
	transitioner.animation_player.play("fade_in")
	$StartButtonPCJANKYYY.grab_focus()

func _on_start_button_pressed():
	transitioner.set_next_animation(true)


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()


