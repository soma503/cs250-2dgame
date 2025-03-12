extends CharacterBody2D
@onready var flash_animation: AnimationPlayer = $Sprite2D/FlashAnimation

var direction: Vector2 = Vector2.ZERO

const GRAVITY = 90
const SPEED = 300.0

#jump
var has_double_jump = true
const JUMP_FORCE = 1200
const DOUBLE_JUMP_FORCE = 1800
@onready var double_jump = $DoubleJump
#dash
const DASH_SPEED = 2000
const DOUBLE_TAP_DELAY = 1000 #in miliseconds
var last_right_tap_time  = 0
var last_left_tap_time = 0
var run_tap_interval = 5.00
@onready var dash = $Dash
var dash_duration = 0.2	
#death
@onready var menu = $menus

#invincibility
@onready var invin = $Invincibility

#stuff
var speed = 1000.0
var acceleration = 1500.0
var air_acceleration = 1000.0
var air_friction = 1000.0
var friction = 5000.0
var gravity = 3500.0
var jump_force = 600
var double_jump_force = 900



#camera
@onready var camera := $Camera2D as Camera2D

func _process(delta):
	$"%Health".text= "Health: " + str(GameManager.health)
	#COINS
	$"Camera2D/Coins".text = str(GameManager.coins)

func _physics_process(delta: float) -> void:
	if menu.can_move:
		apply_gravity(delta)
		handle_jump()
		handle_wall_jump()
		handle_dash()
		
		var input_axis = Input.get_axis("left", "right")
		handle_acceleration(input_axis, delta)
		handle_air_acceleration(input_axis, delta)
		apply_friction(input_axis, delta)
		apply_air_resistance(input_axis, delta)
		
		move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_dash():
	if Input.is_action_just_pressed("dash") and dash.can_dash and !dash.is_dashing(): 
		dash.start_dash(dash_duration)
		
func handle_jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor(): #if player is on the floor, js jump
			velocity.y = -JUMP_FORCE
			has_double_jump = true
			
		elif has_double_jump and not is_on_wall(): 
			velocity.y = -DOUBLE_JUMP_FORCE
			has_double_jump = false

func handle_wall_jump():
	if not is_on_wall(): return
	if is_on_floor(): return
	var wall_normal = get_wall_normal()
	if Input.is_action_pressed("right") and Input.is_action_just_pressed("jump") and wall_normal == Vector2.LEFT:
		velocity.x = wall_normal.x * speed 
		velocity.y = -JUMP_FORCE
	if Input.is_action_pressed("left") and Input.is_action_just_pressed("jump") and wall_normal == Vector2.RIGHT:
		velocity.x = wall_normal.x * speed
		velocity.y = -JUMP_FORCE

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		if dash.is_dashing():
			velocity.x = move_toward(velocity.x, DASH_SPEED * input_axis, air_acceleration * 10 * delta)
		else:
			velocity.x = move_toward(velocity.x, speed * input_axis, air_acceleration * delta)
			
func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		if dash.is_dashing():
			velocity.x = move_toward(velocity.x, DASH_SPEED * input_axis, acceleration * 10 * delta)
		else:
			velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)
			
func apply_friction(input_axis, delta):
	if (input_axis == 0 or get_sign(input_axis) != get_sign(velocity.x)) and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
func apply_air_resistance(input_axis, delta):
	if (input_axis == 0 or get_sign(input_axis) != get_sign(velocity.x)) and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, air_friction * delta)

func get_sign(number):
	if number > 0:
		return 1
	else:
		return -1
		
	
