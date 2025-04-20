extends Node2D
var array = ["res://assets/storyGraphics/storyIntro1.PNG", "res://assets/storyGraphics/storyIntro2.PNG","res://assets/storyGraphics/storyIntro3.PNG",
"res://assets/storyGraphics/storyIntro4.PNG", "res://assets/storyGraphics/storyIntro5.PNG", "res://assets/storyGraphics/storyIntro6.PNG",
"res://assets/storyGraphics/storyIntro7.PNG", "res://assets/storyGraphics/storyIntro8.PNG", "res://assets/storyGraphics/storyIntro9.PNG"]
@onready var canvas = %TextureRect
@onready var startMenu = %StartScreen
var gameStart = false
var n = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas.visible = false
	startMenu.visible = true
	%decisionScreen.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameStart:
		_space_pressed()

func _on_new_game_pressed() -> void:
	##get_tree().change_scene_to_file("res://lvlonetilemap.tscn")
	startMenu.visible = false
	canvas.visible = true
	gameStart = true

func _space_pressed() -> void:
	if Input.is_action_just_pressed("jump") && n < 9:
		canvas.texture = load(array[n])
		n = n + 1
	if Input.is_action_just_pressed("jump") && n == 9:
		%decisionScreen.visible = true

func _on_yes_button_pressed() -> void:
	get_tree().change_scene_to_file("res://lvlonetilemap.tscn")

func _on_no_button_pressed() -> void:
	get_tree().reload_current_scene()
