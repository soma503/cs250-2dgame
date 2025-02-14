extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
const GRAVITY = 30
const SPEED = 300.0

#jump
var has_double_jump = true
const JUMP_FORCE = 600
const DOUBLE_JUMP_FORCE = 900
@onready var double_jump = $DoubleJump
#dash
const DASH_SPEED = 1200
const DOUBLE_TAP_DELAY = 1000 #in miliseconds
var last_right_tap_time  = 0
var last_left_tap_time = 0
var run_tap_interval = 5.00
@onready var dash = $Dash
var dash_duration = 0.2	

#camera
@onready var camera := $Camera2D as Camera2D

func _process(delta):
	direction.x = Input.get_axis("left", "right")
	
	#COINS
	$"Camera2D/Coins".text = str(GameManager.coins)

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY
		if velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump"):
		_try_jump()
			
	if Input.is_action_just_pressed("dash") and dash.can_dash and !dash.is_dashing(): 
		dash.start_dash(dash_duration)
	
	if dash.is_dashing():
		velocity.x = direction.x * DASH_SPEED
	else:
		velocity.x = direction.x * SPEED #move horizontally
		
	move_and_slide()

func _try_jump():
	if is_on_floor(): #if player is on the floor, js jump
		velocity.y = -JUMP_FORCE
		has_double_jump = true
		
	elif has_double_jump: 
		velocity.y = -DOUBLE_JUMP_FORCE
		has_double_jump = false
