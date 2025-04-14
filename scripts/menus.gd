extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func died():
	get_node("deathMenu").died()
	
func pause():
	get_node("pauseMenu").paused()
	
func _process(delta):
	if Input.is_action_pressed("menu"):
		pause()
	
