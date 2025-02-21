extends Node

@onready var durationTimer = $InviTimer
@onready var delayTimer = $DelayTimer
const DURATION = 1
const DELAY = 2
var can_go_invincible = true

func isInvincible():
	return !durationTimer.is_stopped()
	
func isOnDelay():
	return !delayTimer.is_stopped()

func startInvincible():
	durationTimer.wait_time = DURATION
	durationTimer.start()

func _on_invi_timer_timeout() -> void:
	can_go_invincible = false
	delayTimer.wait_time = DELAY
	delayTimer.start()
	
func _on_delay_timer_timeout() -> void:
	can_go_invincible = true
	
