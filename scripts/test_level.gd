extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Player").set_camera_limits(-2900, 24750, -5685, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
