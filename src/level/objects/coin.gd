extends Node2D

@onready var animated_coin = $Sprite2D
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_handle_spin()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		GameManager.coins += 1	
		GameManager.score += 100
		queue_free()

func _handle_spin():
	animated_coin.play("spin")
	
