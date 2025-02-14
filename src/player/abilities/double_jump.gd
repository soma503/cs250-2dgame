extends Node

var is_double_jumping = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func try_double_jump( can_double_jump ):
	if can_double_jump:
		
