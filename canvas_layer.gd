extends CanvasLayer
@onready var label = $Label
@onready var timer = $Timer
const DURATION = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func moveInstruct():
	timerStart()
	label.text = ("use a and d to move \n left and right")
	
func jumpInstruct():
	timerStart()
	label.text = ("press space bar to jump")
	
func doubleInstruct():
	timerStart()
	label.text = ("press space bar twice \n to double jump")
	
func timerStart():
	set_visible(true)
	timer.wait_time = 2.0
	timer.start()

func _on_timer_timeout() -> void:
	set_visible(false)
