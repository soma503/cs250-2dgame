extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_node("Boss").curr_phase == get_parent().get_node("Boss").phase.BEATEN:
		print("appear")
		set_visible(true)

func _on_body_entered(body: Node2D) -> void:
	#ending cutscene here, praying i finish this by saturday night
	print("ending here")
