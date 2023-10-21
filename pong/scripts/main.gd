extends Node

@onready var game: Node = get_node('Game')
@onready var paddle_ai: CharacterBody2D = get_node('Game/PaddleAI')
@onready var pause_menu: Control
@onready var p1_score_ui: RichTextLabel
@onready var p2_score_ui: RichTextLabel

var ball: Resource = load("res://nodes/ball.tscn")

var p1_score: int = 0
var p2_score: int = 0

func _ready() -> void:
	pause_menu = get_node('PauseMenu')
	pause_menu.visible = false
	
	p1_score_ui = get_node('UI/P1Score')
	p2_score_ui = get_node('UI/P2Score')

	p1_score_ui.text = "[center]%s[/center]" % p1_score
	p2_score_ui.text = "[center]%s[/center]" % p2_score

	instantiate_ball(-1)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_cancel') && !get_tree().paused:
		get_tree().paused = true
		pause_menu.visible = true
		pause_menu.set_process(true)

func instantiate_ball(dir: int) -> void:
	var ball_instance: CharacterBody2D = ball.instantiate()
	ball_instance.position = Vector2(320, randi() % 288 + 32)
	ball_instance.speed.x *= dir
	paddle_ai.ball = ball_instance

	game.add_child(ball_instance)

func update_score(player_scoring: int) -> void:
	if player_scoring < 0:
		p2_score += 1
		p2_score_ui.text = "[center]%s[/center]" % p2_score
	elif player_scoring > 0:
		p1_score += 1
		p1_score_ui.text = "[center]%s[/center]" % p1_score
