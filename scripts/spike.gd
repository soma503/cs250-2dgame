extends Node2D

const spike_damage = 1
var count := 0
var can_attack = true
var area_being_hit : HitboxComponent
var attack : Attack

@onready var timer = $Timer

func _ready():
	attack = Attack.new()
	attack.attack_damage = spike_damage

func _physics_process(delta: float) -> void:
	if can_attack and is_in_hitbox(count):
		if area_being_hit != null:
			area_being_hit.damage(attack)
		can_attack = false
		timer.start()
		
func _on_area_2d_area_entered(area):
	print("ENTERED!!!")
	count += 1
	if area is HitboxComponent and is_in_hitbox(count):
		area_being_hit = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	area_being_hit = null
	can_attack = true
	count += 1

func is_in_hitbox(count):
	if count % 2 == 0:
		return false
	else:
		return true

func _on_timer_timeout() -> void:
	can_attack = true
