extends CanvasLayer
##var can_move = true
@onready var timer = $Timer
const duration = 2.5
var dying = false

func _ready():
	set_visible(false)
	
func died():
	dying = true
	timer.wait_time = duration
	timer.start()
	get_tree().call_group("Player","dies")
	print("there")

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


func _on_timer_timeout() -> void:
	print("here")
	set_visible(true)
	GameManager.is_paused = true
	dying = false
