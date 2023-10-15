extends Node

@onready var paddle_ai: CharacterBody2D = get_node('PaddleAI')
@onready var p1_score_ui: RichTextLabel = get_node('Control/P1Score')
@onready var p2_score_ui: RichTextLabel = get_node('Control/P2Score')

var ball: Resource = load("res://nodes/ball.tscn")

var p1_score: int = 0
var p2_score: int = 0

func _ready() -> void:
	p1_score_ui = get_node('Control/P1Score')
	p2_score_ui = get_node('Control/P2Score')

	p1_score_ui.text = "[center]%s[/center]" % p1_score
	p2_score_ui.text = "[center]%s[/center]" % p2_score

	instantiate_ball(-1)

func instantiate_ball(dir: int) -> void:
	var ball_instance: CharacterBody2D = ball.instantiate()
	ball_instance.position = Vector2(320, randi() % 288 + 32)
	ball_instance.speed.x *= dir
	paddle_ai.ball = ball_instance

	add_child(ball_instance)

func update_score(player_scoring: int) -> void:
	if player_scoring < 0:
		p2_score += 1
		p2_score_ui.text = "[center]%s[/center]" % p2_score
	elif player_scoring > 0:
		p1_score += 1
		p1_score_ui.text = "[center]%s[/center]" % p1_score
