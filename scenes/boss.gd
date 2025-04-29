extends CharacterBody2D

const SPEED = 1000

@export var player : Player

@onready var attack_cooldown = $AttackCooldown

var dir : Vector2
var initial_position : Vector2
var height_limit = 1000

func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	if not GameManager.is_paused:
		handle_direction()
		handle_movement()
		
		move_and_slide()
		
func handle_movement():
	print( abs(position.y - initial_position.y) )
	#BUG once it hits the height limit, it stops moving
	if abs(position.y - initial_position.y) < height_limit:
		velocity.y = SPEED * dir.y
	
func handle_direction():
	dir = (player.position - position).normalized()

func shoot_burst():
	pass

func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		shoot_burst()
