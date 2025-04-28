extends CharacterBody2D


const JUMP_VELOCITY = -400.0
const PATROL_SPEED = 300.0
var on_ledge = false
var dir = -1
var sees_player = false

@onready var rand_timer = $RandomMovementTimer  #prob not needed
@onready var left_ray = $ray_left
@onready var right_ray = $ray_right

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not GameManager.is_paused:
		if sees_player:
			print("SEES PLAYER SEES PLAYER!!!!!")
			aggro_towards()
		else:
			patrol()
			apply_gravity(delta)
		
		move_and_slide()
		

# patrol
#Changes motion of entity depending on which direction it is facing and if it on a ledge
func patrol():
	update_direction()
	if is_on_ledge():
		velocity.x = PATROL_SPEED * dir
		

# update_direction
# Gets the direction of entity depending on if it has hit the end of a ledge and updates it
func update_direction():
	if !left_ray.is_colliding():
		dir = 1 #going right
	if !right_ray.is_colliding():
		dir = -1 #going left

# is_on_ledge
# Checks if entity is on a ledge or not and returns a bool for the result
# Uses two raycasts downwards to check either its right side or left side is off the platform
func is_on_ledge():
	if ( !left_ray.is_colliding() or !right_ray.is_colliding() ):
		return true
	return false
	
func aggro_towards():
	pass
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += GameManager.gravity * delta


func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		sees_player = true
	else:
		sees_player = false
