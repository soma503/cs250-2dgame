extends CharacterBody2D

const SPEED = 1500

enum phase  {
	LOADING,
	FIGHT,
	STUNNED,
	BEATEN,
}

@export var player : Player
@export var feather : PackedScene

@onready var attack_cooldown = $AttackCooldown
@onready var phase_timer = $PhaseDuration

var dir : Vector2
var initial_position : Vector2
var height_limit = 1000
var can_attack = false
var curr_phase = phase.LOADING
var boss_health = 3

func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	if not GameManager.is_paused:
		match curr_phase:
			phase.LOADING:
				# TODO add a loading phase... a setup phase where the bird does smthn and player can prepare
				curr_phase = phase.FIGHT
			phase.FIGHT:
				phase_timer.start()
				handle_direction()
				handle_movement()
				handle_attack()
				move_and_slide()
				if phase_timer.is_stopped():
					update_stunned_condition()
					
			phase.STUNNED:
				# TODO way to actually do damage to boss
				if boss_health <= 0:
					curr_phase = phase.BEATEN
					
			phase.BEATEN:
				# TODO make an ending :p
				pass

func update_stunned_condition():
	curr_phase = phase.STUNNED

func update_difficulty():
	attack_cooldown.wait_time -= 0.5
	pass

func handle_movement():
	if is_at_height_limit():
		velocity.y = SPEED * dir.y
	else:
	#BUG once it hits the height limit, it stops moving permanently
	# needs some better logic
		velocity.y = 0

func is_at_height_limit():
	return abs(position.y - initial_position.y) < height_limit
	
# handle_direction
# Updates the direction for the boss to travel based on player position
func handle_direction():
	dir = (player.position - position).normalized()

# handle_attack
# Calls shoot_burst() if it can_attack and its attack is not on cooldown
func handle_attack():
	if can_attack and attack_cooldown.is_stopped():
		shoot_burst()
		attack_cooldown.start()
		
# shoot_burst
# Instantiates 3 feathers, 0.5 sec apart, at the boss's location
func shoot_burst():
	for n in 3:
		print("spawning dem")
		var new_feather = feather.instantiate()
		new_feather.global_transform = global_transform
		get_parent().add_child(new_feather)
		await get_tree().create_timer(0.5).timeout
	
func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		can_attack = true

func _on_detect_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_attack = false
		
