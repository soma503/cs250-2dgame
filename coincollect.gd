extends Node
var coinCounter = 0;
@onready var coinLabel = %coins

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#connected to Area2D of player
#when player is in the Area2D of the coin, it will add one to the coin couter
func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("here")
	setCount(coinCounter + 1)
	
#updates the coin count and updates the label
func setCount(newCoinCount:int) -> void:
	coinCounter = newCoinCount
	coinLabel.text = "x " + str(coinCounter)
