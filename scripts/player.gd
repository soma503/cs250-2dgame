extends CharacterBody2D



@onready var double_jump = $DoubleJump
@onready var menu = $menus
@onready var dash = $Abilities/Dash
@onready var animated_sprite = $Sprite2D
@onready var camera := $Camera2D as Camera2D

var speed = 2000.0
var dash_speed = 3000
var acceleration = 3000.0
var air_acceleration = 1500.0
var air_friction = 4000.0
var friction = 9000.0
var jump_force = 2500
var double_jump_force = 2600
var direction: Vector2 = Vector2.ZERO
var has_double_jump = true
var dash_duration = 0.2	


#camera


func _process(delta):
	$"Health".text= "Health: " + str(GameManager.health)
	$"Coins".text = str(GameManager.coins)
	
func _physics_process(delta: float) -> void:
	if not GameManager.is_paused:
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
		handle_animation(input_axis)

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += GameManager.gravity * delta

func handle_dash():
	if Input.is_action_just_pressed("dash") and dash.can_dash and !dash.is_dashing(): 
		$HitFlashAnimationPlayer.play()
		dash.start_dash(dash_duration)
		
func handle_jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor(): #if player is on the floor, js jump
			velocity.y = -jump_force
			has_double_jump = true
			
		elif has_double_jump and not is_on_wall(): 
			velocity.y = -double_jump_force
			has_double_jump = false

func handle_wall_jump():
	if not is_on_wall(): return
	if is_on_floor(): return
	var wall_normal = get_wall_normal()
	if Input.is_action_pressed("right") and Input.is_action_just_pressed("jump") and wall_normal == Vector2.LEFT:
		velocity.x = wall_normal.x * speed 
		velocity.y = -double_jump_force
	if Input.is_action_pressed("left") and Input.is_action_just_pressed("jump") and wall_normal == Vector2.RIGHT:
		velocity.x = wall_normal.x * speed
		velocity.y = -double_jump_force

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		if dash.is_dashing():
			velocity.x = move_toward(velocity.x, dash_speed * input_axis, air_acceleration * 10 * delta)
		else:
			velocity.x = move_toward(velocity.x, speed * input_axis, air_acceleration * delta)
			
func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		if dash.is_dashing():
			velocity.x = move_toward(velocity.x, dash_speed * input_axis, acceleration * 10 * delta)
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

func handle_animation(input_axis):
	if input_axis != 0:
		animated_sprite.flip_h = (input_axis < 0) #this sets the way sprite is facing
		animated_sprite.play("running")
	else:
		animated_sprite.play("idle") 
	if not is_on_floor():
		animated_sprite.play("jumping")
		
		
