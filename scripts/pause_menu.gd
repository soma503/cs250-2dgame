extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_visible(false);

func paused():
	set_visible(true)
	GameManager.is_paused = true

func _on_resume_pressed() -> void:
	set_visible(false)
	GameManager.is_paused = false

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	GameManager.health = 3
	GameManager.is_paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()
