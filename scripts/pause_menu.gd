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

#this will reload the current scene and reset the health, coins, and score to what it was before level started
func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	GameManager.health = GameManager.finalHealth
	GameManager.coins = GameManager.finalCoins
	GameManager.score = GameManager.finalScore
	GameManager.is_paused = false
	set_visible(false)

func _on_quit_pressed() -> void:
	get_tree().quit()
