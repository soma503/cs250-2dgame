extends Area2D

const SPEED = -750

var attack : Attack
var damage = 1

@onready var ray_cast = $RayCast2D

func _ready() -> void:
	attack = Attack.new()
	attack.attack_damage = damage

func _process(delta: float) -> void:
	if not GameManager.is_paused:
		handle_movement(delta)
		handle_environment_collision()

# handle_movement
# Updates the position of the bullet using its speed
func handle_movement(delta):
	position += transform.x * SPEED * delta
	
# handle_environment_collision
# Uses a ray cast to delete itself if colliding with the environment
func handle_environment_collision():
	if ray_cast.is_colliding():
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage(attack)
		queue_free()
		
