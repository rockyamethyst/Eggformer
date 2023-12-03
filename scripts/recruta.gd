extends CharacterBody2D

const SPEED = 125.0
const JUMP_VELOCITY = -250.0

# Transitioner related jank
@export var scene_switch : String = "fade_out"
@export var transitioner : Transitioner
@export var scene_to_load : PackedScene
@export var hard_mode_scene_to_load : PackedScene

@onready var recruta := $anim as AnimatedSprite2D
@onready var spawn_pos = recruta.position
@export var base_limit = 0
@export var limit_of_right_map = 0
@export var limit_of_left_map = 0
@export var awaken = 1
@export var is_flippin = false
@export var LeftSideOfMap = -1
@export var spawn_direction = 1
@onready var level_song = $"../levelsong"
@onready var victory_song = $"../victory"
var is_finished = 0
var can_has_death := true
var deceleration = 30
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_sliding = 0
var is_jumping := false 
var slide_direction = 0
var bonkd = false
var has_checkpoint = false
var checkpoint_pos: Vector2 = Vector2(0, 0)
var current_checkpoint: int = -1
var coin_count = 0 




func _ready():
	$camera.limit_left = base_limit 
	$camera.limit_right = limit_of_right_map
	recruta.scale.x = spawn_direction

func undertalecosplay(_body):
	can_has_death = true
	respawn()


func bonk():
	recruta.play("hurt")
	velocity.y = -300
	velocity.x = slide_direction * 125
	bonkd = true
	if velocity.y == 0:
		can_has_death = true
		bonk()
	


func respawn():
	if(has_checkpoint):
		position = checkpoint_pos
		recruta.play("respawn")
	else:
		position = spawn_pos
		recruta.play("respawn")

func _on_anim_animation_finished():
	if is_finished == 1:
		transitioner.scene_to_load = scene_to_load
		transitioner.scene_switch = scene_switch
		transitioner.animation_player.play("fade_out")
	elif can_has_death:
		can_has_death = false
		spawn_pos = recruta.global_position
		return move_and_slide()


func _physics_process(delta):
	if can_has_death:
		transitioner.set_next_animation(false)
		return
	elif is_on_floor() and is_finished:
		return
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
		elif is_on_floor:
			is_jumping = false



		if Input.is_action_pressed("peng_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY 
			is_jumping = true
			$Jump.play()

	var direction = Input.get_axis("peng_left", "peng_right")
	var is_moving = abs(direction) > 0.1
	if is_jumping: 
		if abs(velocity.x) > 0.1:
			velocity.x = move_toward(velocity.x, 0, SPEED / deceleration)
		else:
			velocity.x = 0
	else:  # Not jumping, set velocity to zero
		velocity.x = 0



	# Apply movement based on direction
	if is_moving:
		if velocity.x >= 126 or velocity.x <= -126:
			recruta.scale.x = direction
			slide_direction = direction
			$camera.position.x = direction * 16 
		else:
			velocity.x = SPEED * direction
			recruta.scale.x = direction
			slide_direction = direction
			$camera.position.x = direction * 16  
	# print_debug("Vertical: ", velocity.y, "Horizontal: ", velocity.x)



	if is_jumping:
		recruta.play("jump")
	elif is_sliding >= 1:
		sliding()
	elif is_moving:
		recruta.play("walk")
	elif can_has_death:
		respawn()
	else:
		recruta.play("idle")


	var lookdirection = Input.get_action_strength("peng_up") - Input.get_action_strength("peng_down")
	if velocity.x != 0:
		return move_and_slide()
	elif lookdirection > 0.5:
		recruta.play("look_up")
	elif lookdirection < -0.5:
		recruta.play("look_down")

	move_and_slide()

func sliding():
	velocity.x = slide_direction * 300
	recruta.play("slide")


func YES_I_KNOW_ITS_JANK_BUT_IT_WILL_DO(_body):
	is_finished = 1


func _process(delta):
	if is_on_floor() and is_finished == 1:
		recruta.play("victory")
		if !victory_song.is_playing():
			level_song.playing = false
			victory_song.play()
	elif is_on_floor() and is_finished == 69:
		recruta.play("walk")
		velocity.x = SPEED * slide_direction
		move_and_slide()
	# print_debug("Coins: ", coin_count)
	if is_flippin:
		if LeftSideOfMap == -1:
			$camera.limit_left = limit_of_left_map
			$camera.limit_right = base_limit
			LeftSideOfMap = 1 
	else:
		LeftSideOfMap = -1
		$camera.limit_left = base_limit
		$camera.limit_right = limit_of_right_map


func go_deeper_recruta(body):
	is_finished = 69


func time_to_die(body):
	transitioner.scene_to_load = hard_mode_scene_to_load
	transitioner.scene_switch = scene_switch
	transitioner.animation_player.play("fade_out")
	velocity.x = 0
	recruta.play("idle")
