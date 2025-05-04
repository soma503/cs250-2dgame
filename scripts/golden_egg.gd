extends Area2D
var onEgg = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().get_node("Boss").curr_phase == get_parent().get_node("Boss").phase.BEATEN:
		print("appear")
		set_visible(true)
	if onEgg && Input.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/end_scene.tscn")

func _on_body_entered(body: Node2D) -> void:
	onEgg = true
	
