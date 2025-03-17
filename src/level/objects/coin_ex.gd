extends Node
var coinCounter = 0
@onready var coinLabel = %coins

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	setCount(coinCounter + 1)
	
func setCount(newCoinCount:int) -> void:
	coinCounter = newCoinCount
	coinLabel.text = "Coins: " + str(coinCounter)
