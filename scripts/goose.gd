extends CharacterBody2D


const JUMP_VELOCITY = -400.0
const PATROL_SPEED = 300.0
const AGGRO_SPEED = 600.0

var on_ledge = false
var dir : Vector2
var sees_player = false
var target = null
var target_hitbox_comp = null
var attack : Attack
var damage = 1
var can_attack = false
var count = 0


@onready var rand_timer = $RandomMovementTimer  #prob not needed
@onready var left_ray = $ray_left
@onready var right_ray = $ray_right
@onready var attack_cooldown = $AttackArea/AttackCooldown

func _ready() -> void:
	attack = Attack.new()
	attack.attack_damage = damage

func _physics_process(delta: float) -> void:
	if not GameManager.is_paused:
		if sees_player:
			print("SEES PLAYER SEES PLAYER")
			aggro_towards()
		else:
			patrol()
			apply_gravity(delta)
		
		handle_attack()
		move_and_slide()

# patrol
# Changes motion of entity depending on which direction it is facing and if it on a ledge
func patrol():
	update_direction_from_ledge()
	velocity.x = PATROL_SPEED * dir.x
		

# update_direction_from_ledge
# Gets the direction of entity depending on if it has hit the end of a ledge and updates it
func update_direction_from_ledge():
	if !left_ray.is_colliding():
		dir.x = 1 #going right
	if !right_ray.is_colliding():
		dir.x = -1 #going left
		
# update_direction_to_player
# updates direction so that it is facing the player
func update_direction_to_player():
	dir = (target.position - position).normalized()

# is_on_ledge
# Checks if entity is on a ledge or not and returns a bool for the result
# Uses two raycasts downwards to check either its right side or left side is off the platform
func is_on_ledge():
	if ( !left_ray.is_colliding() or !right_ray.is_colliding() ):
		return false
	return true
	
# aggro_towards
# uses aggro speed to update velocity to follow player
func aggro_towards():
	if is_on_ledge():
		update_direction_to_player()
		velocity.x = AGGRO_SPEED * dir.x
	else:
		update_direction_from_ledge()
		velocity.x = AGGRO_SPEED * dir.x
		
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += GameManager.gravity * delta

func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		target = body
		sees_player = true
	else:
		sees_player = false

func _on_detect_area_body_exited(body: Node2D) -> void:
	sees_player = false

func _on_attack_area_area_entered(area: Area2D) -> void:
	count += 1
	if area is HitboxComponent and (count % 2 != 0):
		target_hitbox_comp = area
		
func _on_attack_area_area_exited(area: Area2D) -> void:
	target_hitbox_comp = null
	can_attack = true
	count += 1
	
func handle_attack():
	if can_attack and (count % 2 != 0 ):
		if target_hitbox_comp != null:
			target_hitbox_comp.attack(attack)
		can_attack = false
		attack_cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	can_attack = true
