extends Area2D
var spike_damage = 1
@onready var health = $health

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		pass
		#body.take_damage(spike_damage)
