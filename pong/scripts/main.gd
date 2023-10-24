extends Node

@onready var game: Node = get_node('Game')
@onready var paddle_ai: CharacterBody2D = get_node('Game/PaddleAI')
@onready var pause_menu: Control
@onready var end_game_menu: Control
@onready var p1_score_ui: RichTextLabel
@onready var p2_score_ui: RichTextLabel

@onready var goal_a: AudioStreamPlayer = $AudioEffects/GoalA
@onready var goal_b: AudioStreamPlayer = $AudioEffects/GoalB
@onready var lost: AudioStreamPlayer = $AudioEffects/Lost
@onready var won: AudioStreamPlayer = $AudioEffects/Won

@export var max_score: int = 3

var ball: Resource = load("res://nodes/ball.tscn")

var p1_score: int = 0
var p2_score: int = 0

var played_end_audio: bool = false

func _ready() -> void:
	EventBus.connect('goal_scored', mark_score)
	
	pause_menu = get_node('PauseMenu')
	pause_menu.visible = false
	
	end_game_menu = get_node('EndGameMenu')
	end_game_menu.visible = false
	
	p1_score_ui = get_node('UI/P1Score')
	p2_score_ui = get_node('UI/P2Score')
	
	p1_score_ui.text = "[center]%s[/center]" % p1_score
	p2_score_ui.text = "[center]%s[/center]" % p2_score

	instantiate_ball(-1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_cancel') && !get_tree().paused:
		transition_to_menu(pause_menu)
	
	if p1_score >= max_score:
		play_end_audio(won)
		end_game_menu.set_game_won_screen()
		transition_to_menu(end_game_menu)
	
	if p2_score >= max_score:
		play_end_audio(lost)
		end_game_menu.set_game_over_screen()
		transition_to_menu(end_game_menu)

func mark_score(dir: int) -> void:
	instantiate_ball(dir)
	update_score(dir)

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
		goal_a.play()
	elif player_scoring > 0:
		p1_score += 1
		p1_score_ui.text = "[center]%s[/center]" % p1_score
		goal_b.play()

func transition_to_menu(menu: Control):
	get_tree().paused = true
	menu.visible = true
	menu.set_process(true)

func play_end_audio(audio: AudioStreamPlayer):
	if !played_end_audio:
		played_end_audio = true
		audio.play()
