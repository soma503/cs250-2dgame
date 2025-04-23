extends CanvasLayer
@onready var canvas = %TextureRect2
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
	canvas.texture = load("res://assets/UI Graphics/PopUpIntro.png")
	label.text = (" ")
	
func jumpInstruct():
	timerStart()
	canvas.texture = load("res://assets/UI Graphics/JumpIntro.png")
	label.text = (" ")
	
func doubleInstruct():
	timerStart()
	label.text = ("Press JUMP twice \n to double jump")
	
func wallInstruct():
	timerStart()
	label.text = ("Jump wall to wall \n by pressing space")
	
func dashInstruct():
	timerStart()
	label.text = (" ")
	canvas.texture = load("res://assets/UI Graphics/popUpDash.png")
	
func timerStart():
	set_visible(true)
	timer.wait_time = 2.0
	timer.start()

func _on_timer_timeout() -> void:
	set_visible(false)
