extends CanvasLayer
##var can_move = true

func _ready():
	set_visible(false)
	
func died():
	set_visible(true)
	get_parent().can_move = false

#this will reload the current scene and reset the health, coins, and score to what it was before level started
func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	GameManager.health = GameManager.finalHealth
	GameManager.coins = GameManager.finalCoins
	GameManager.score = GameManager.finalScore
	get_parent().can_move = true
	set_visible(false)
	

func _on_quit_pressed() -> void:
	get_tree().quit()
