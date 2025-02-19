extends Node

@onready var invin_timer = $invinTimer
@onready var delay_timer = $invinDelay
const INVIN_TIME = 4

const DELAY = 4
var isInvin = false;
var  can_be_hit = true
var on_delay = false

"""
func startInvin(duration):
	isInvin = true
	duration_timer.wait_time = duration
	duration_timer.start()  
"""
	
func become_invin( duration ):
	can_be_hit = false
	invin_timer.wait_time = duration
	invin_timer.start()

func end_invin():
	can_be_hit = true
	delay_timer.wait_time = DELAY
	on_delay = true
	delay_timer.start()
	
	
	

# Called when the node enters the scene tree for the first time.
func damage() -> void:
	print(can_be_hit)
	if can_be_hit:  #MAKE SURE DELAY TIMER IS STOPPD BEFORE BEING ABLE TO BE HIT
		GameManager.health -= 1
		if !on_delay:
			become_invin(INVIN_TIME)

func _on_health_timer_timeout() -> void:
	end_invin()


func _on_invin_delay_timeout() -> void:
	on_delay = false
