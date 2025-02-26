extends CanvasLayer

func _ready():
	set_visible(false)
	
func died():
	#get_tree().change_scene_to_file("res://src/player/death.tscn")
	set_visible(true)
	
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	GameManager.health = 3
