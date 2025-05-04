extends CharacterBody2D

const SPEED = 1500
const MAX_HEALTH = 3
const KNOCKBACK = Vector2(2000, 2000)

enum phase  {
	LOADING,
	FIGHT,
	STUNNED,
	BEATEN,
}

enum height {
	TOP,
	BOTTOM,
	MIDDLE
}


@export var player : Player
@export var feather : PackedScene

@onready var attack_cooldown = $AttackCooldown
@onready var phase_timer = $PhaseTimer
@onready var stunned_timer = $StunnedTimer
@onready var stomped_timer = $StompedCooldown
@onready var animations = $AnimationPlayer
@onready var sprite = $Sprite2D

var dir : Vector2
var initial_position : Vector2
var height_limit = 1000
var can_attack = false
var curr_phase = phase.LOADING
var boss_health = MAX_HEALTH
var curr_height = height.MIDDLE
var was_stomped = false
var phase_duration = 15
var stunned_duration = 5
var stomp_count = 0

func _ready() -> void:
	initial_position = position
	phase_timer.wait_time = phase_duration
	stunned_timer.wait_time = stunned_duration
	attack_cooldown.wait_time = 3

func _physics_process(delta: float) -> void:
	if not GameManager.is_paused:
		print("HEALTH:", boss_health) 
		match curr_phase:
			phase.LOADING:
				# TODO add a loading phase... a setup phase where the bird does smthn and player can prepare
				sprite.play("flying")
				animations.play("grow")
				await get_tree().create_timer(3).timeout
				phase_timer.start()
				print("in fight phase")
				curr_phase = phase.FIGHT
			phase.FIGHT:
				sprite.play("flying")
				handle_direction()
				handle_movement()
				handle_attack()
				move_and_slide()
					
			phase.STUNNED:
				# logic is in _on_stomp_area_body_entered() func
				print("IS STUNNED")
				sprite.play("stunned")
				if boss_health <= 0:
					curr_phase = phase.BEATEN
					
			phase.BEATEN:
				#animations.play("shrink")
				await get_tree().create_timer(3).timeout
				sprite.play("dead")
				get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
				# TODO make an ending :p

func update_difficulty():
	attack_cooldown.wait_time -= 1

func handle_movement():
	if (curr_height == height.TOP) and (dir.y > 0):
		velocity.y = 0
	elif (curr_height == height.BOTTOM) and (dir.y > 0):
		velocity.y = 0
	else:
		velocity.y = SPEED * dir.y

func handle_height_limit():
	if (position.y - initial_position.y) > height_limit:
		curr_height = height.TOP
	elif (position.y - initial_position.y) < -height_limit:
		curr_height = height.BOTTOM
	else:
		curr_height = height.MIDDLE

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
		
func handle_stomped():
	boss_health -= 1
	player.apply_knockback(KNOCKBACK)
	update_difficulty()

# shoot_burst
# Instantiates 3 feathers, 0.5 sec apart, at the boss's location
func shoot_burst():
	for n in 3:
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
		
func _on_stomp_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player') and (curr_phase == phase.STUNNED):
		handle_stomped()
		
		if boss_health > 0:
			phase_timer.start()
			print("in fight phase")
			curr_phase = phase.FIGHT
		else:
			print("ENDING")
			curr_phase = phase.BEATEN

func _on_stunned_timer_timeout() -> void:
	if boss_health > 0 and (curr_phase != phase.FIGHT):
		phase_timer.start()
		print("in fight phase")
		curr_phase = phase.FIGHT

func _on_phase_timer_timeout() -> void:
	stunned_timer.start()
	print("in stunned phase")
	curr_phase = phase.STUNNED
