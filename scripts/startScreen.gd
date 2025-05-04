extends Node2D
var array = ["res://assets/Story Graphics/storyIntro1.PNG","res://assets/Story Graphics/storyIntro2.PNG","res://assets/Story Graphics/storyIntro3.PNG",
"res://assets/Story Graphics/storyIntro4.PNG","res://assets/Story Graphics/storyIntro5.PNG","res://assets/Story Graphics/storyIntro6.PNG","res://assets/Story Graphics/storyIntro7.PNG",
"res://assets/Story Graphics/storyIntro8.PNG","res://assets/Story Graphics/storyIntro9.PNG"]
var gameStart = false
var n = 1

#makes only the starting screen visible when played
func _ready() -> void:
	Bgm.play_music_level()
	
	%CanvasLayer.visible = true
	%TextureRect.visible = false
	%DecisionScreen.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameStart:
		_story_progess()

#if NEW GAME button pressed on start screen
#then story slide 1 becomes visible
func _on_button_pressed() -> void:
	%CanvasLayer.visible = false
	%TextureRect.visible = true
	gameStart = true

#flips through the array when "jump" button is pressed
func _story_progess() -> void:
	if Input.is_action_just_pressed("jump") && n < 9:
		%TextureRect.texture = load(array[n])
		n = n + 1
	if Input.is_action_just_pressed("jump") && n == 9:
		%DecisionScreen.visible = true


#when yes button is pressed, will load player into level 1
func _on_button_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

#when no button is pressed, will reload back to the start screen
func _on_button_no_pressed() -> void:
	get_tree().reload_current_scene()
