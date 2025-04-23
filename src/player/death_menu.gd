extends CanvasLayer
##var can_move = true

func _ready():
	set_visible(false)
	
func died():
	set_visible(true)
	get_parent().can_move = false

func _on_retry_pressed() -> void:
	set_visible(false)
	get_tree().reload_current_scene()
	GameManager.health = 3
	get_parent().can_move = true

func _on_quit_pressed() -> void:
	get_tree().quit()
