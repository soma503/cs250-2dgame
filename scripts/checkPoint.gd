extends Area2D
#You will need to make a new instance of this code for every checkpoint 
#Later on, this is where we can add actually saving, but for now this just updates variable in gameManager

@export var scene_path : String


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Transport to different scene/level. 
#Updates the "final" versions of coins, health, and score to reflect what they collected in the level
func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file(scene_path)
	GameManager.finalCoins = GameManager.coins
	GameManager.finalHealth = GameManager.health
	GameManager.finalScore = GameManager.score
