extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var has_double_jump = true
const GRAVITY = 30
const SPEED = 300.0
const JUMP_FORCE = 600

const DASH_SPEED = 900
var dashing = false
var can_dash = true

func _process(delta):
	direction.x = Input.get_axis("left", "right")

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY
		if velocity.y > 1000:
			velocity.y > 1000
	
	if Input.is_action_just_pressed("jump"):
		_try_jump()
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$DashTimer.start()
		$DashAgainTimer.start()
	
	if dashing:
		velocity.x =direction.x * DASH_SPEED
	else:
		velocity.x = direction.x * SPEED #move horizontally
		
	move_and_slide()

func _try_jump():
	if is_on_floor(): #if player is on the floor, js jump
		velocity.y = -JUMP_FORCE
		has_double_jump = true
	else: 
		if has_double_jump: 
			velocity.y = -JUMP_FORCE
			has_double_jump = false

func _on_dash_timer_timeout() -> void:
	dashing = false
	
func _on_dash_again_timer_timeout() -> void:
	can_dash = true  
