extends Node


const wall_jump_pushback = 1000
const wall_slide_gravity = 1000
var is_wall_sliding = false

# Called when the node enters the scene tree for the first time.
func left_jump_off_wall(JUMP_FORCE,velocity):
	velocity.y = JUMP_FORCE
	velocity.x = -wall_jump_pushback
func right_jump_off_wall(JUMP_FORCE, velocity):
	velocity.y = JUMP_FORCE
	velocity.x = wall_jump_pushback

func wall_slide(delta,velocity):
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		is_wall_sliding = true
	if is_wall_sliding:
		velocity.y += (wall_slide_gravity * delta)
		velocity.y = min(velocity.y, wall_slide_gravity)
