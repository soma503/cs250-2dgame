extends Node
var can_move = true
var is_paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func died():
	get_node("deathMenu").died()
	
func pause():
	get_node("pauseMenu").paused()
