extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_visible(false);

func paused():
	set_visible(true)
	get_parent().is_paused = true
	get_parent().can_move = false

func _on_resume_pressed() -> void:
	set_visible(false)
	get_parent().is_paused = false
	get_parent().can_move = true

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	GameManager.health = GameManager.finalHealth
	GameManager.coins = GameManager.finalCoins
	get_parent().can_move = true
	get_parent().is_paused = false
	set_visible(false)

func _on_quit_pressed() -> void:
	get_tree().quit()
