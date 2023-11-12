extends CharacterBody2D

const SPEED = 125.0
const JUMP_VELOCITY = -250.0

@onready var recruta := $anim as AnimatedSprite2D
@onready var spawn_pos = recruta.position
@onready var flip_zone = get_node("/root/World/Flip Zone")
@export var transitioner : Transitioner


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_has_death := true
var is_sliding = 0
var is_jumping := false 
var slide_direction = 0
var LeftSideOfMap = 0
var deceleration = 30
var bonkd = false
var has_checkpoint = false
var checkpoint_pos: Vector2 = Vector2(0, 0)
var current_checkpoint: int = -1

func undertalecosplay(_body):
	can_has_death = true
	respawn()


func bonk():
	velocity.y = 0
	velocity.x = 0
	velocity.y = -300
	velocity.x = slide_direction * 125
	bonkd = true
	if velocity.y == 0:
		can_has_death = true
		respawn()
	
	recruta.play("hurt")


func respawn():
	if LeftSideOfMap:
		$camera.limit_left = -10000000
		$camera.limit_right = -96
	else:
		$camera.limit_left = -96
		$camera.limit_right = 3488
	if(has_checkpoint):
		position = checkpoint_pos
		recruta.play("respawn")
	else:
		position = spawn_pos
		recruta.play("respawn")

func _on_anim_animation_finished():
		can_has_death = false
		spawn_pos = recruta.global_position
		return move_and_slide()

func CameraFlip():
	if LeftSideOfMap == 0:
		$camera.limit_left = -10000000
		$camera.limit_right = -92
		LeftSideOfMap = 1
	else:
		LeftSideOfMap = 0
		$camera.limit_left = -92
		$camera.limit_right = 10000000

func _physics_process(delta):
	if can_has_death:
		transitioner.set_next_animation(false)
		return
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
		elif is_on_floor:
			is_jumping = false
		# if velocity.y >= 0 && bonkd:
			# respawn()
	# Handle Jump.
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
			# velocity.x = velocity.x * direction
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


func YES_I_KNOW_ITS_JANK_BUT_IT_WILL_DO(body):
	get_tree().change_scene_to_packed(load("res://levels/Level2.tscn"))
