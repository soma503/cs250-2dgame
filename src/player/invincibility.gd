extends Node

@onready var durationTimer = $InviTimer
const DURATION = 0.5

func isInvincible():
	return not durationTimer.is_stopped()
	
func startInvincible():
	durationTimer.wait_time = DURATION
	durationTimer.start()
