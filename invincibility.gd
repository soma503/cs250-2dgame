extends Node

@onready var durationTimer = $InviTimer
@onready var delayTimer = $DelayTimer
const DURATION = 3
const DELAY = 3
var can_be_hit = true

func isInvincible():
	return !durationTimer.is_stopped()
	
func isOnDelay():
	return !delayTimer.is_stopped()

func startInvincible():
	durationTimer.wait_time = DURATION
	durationTimer.start()

func _on_invi_timer_timeout() -> void:
	can_be_hit = false
	delayTimer.wait_time = DELAY
	delayTimer.start()
	can_be_hit = true
