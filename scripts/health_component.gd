extends Node2D

class_name HealthComponent

@export var MAX_HEALTH := 10
@export var hit_flash : AnimationPlayer
@export var hit_sfx : AudioStreamPlayer2D
var health : float

func _ready() -> void:
	health = MAX_HEALTH
	GameManager.health = health

func damage(attack: Attack):
	health -= attack.attack_damage
	GameManager.health = health
	if hit_sfx:
		hit_sfx.play()
	if hit_flash:
		hit_flash.play("hit_flash")
	
	if GameManager.health < 0:
		GameManager.health = 0
