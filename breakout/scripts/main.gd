extends Node

@onready var game: Node = get_node('Game')
@onready var pause_menu: Control
@onready var end_game_menu: Control
@onready var score_ui: RichTextLabel
@onready var health_ui: RichTextLabel

@onready var goal_a: AudioStreamPlayer = $AudioEffects/GoalA
@onready var goal_b: AudioStreamPlayer = $AudioEffects/GoalB
@onready var lost: AudioStreamPlayer = $AudioEffects/Lost
@onready var won: AudioStreamPlayer = $AudioEffects/Won

@onready var paddle: CharacterBody2D = $Game/Paddle

@export var max_score: int = 3

var ball: Resource = load("res://nodes/ball.tscn")

var score: int = 0
var health: int = 2

var played_end_audio: bool = false

func _ready() -> void:
	EventBus.connect('on_ball_destruction', apply_damage)
	EventBus.connect('on_block_destruction', mark_score)
	
	pause_menu = get_node('PauseMenu')
	pause_menu.visible = false
	
	end_game_menu = get_node('EndGameMenu')
	end_game_menu.visible = false
	
	score_ui = get_node('UI/Score')
	health_ui = get_node('UI/Health')
	
	score_ui.text = "[center]%s[/center]" % score
	health_ui.text = "[center]%s[/center]" % health
	
	instantiate_ball()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed('ui_cancel') && !get_tree().paused:
		transition_to_menu(pause_menu)
	
	# if p1_score >= max_score:
	# 	play_end_audio(won)
	# 	end_game_menu.set_game_won_screen()
	# 	transition_to_menu(end_game_menu)
	
	# if p2_score >= max_score:
	# 	play_end_audio(lost)
	# 	end_game_menu.set_game_over_screen()
	# 	transition_to_menu(end_game_menu)

func mark_score(value: int) -> void:
	score += value
	score_ui.text = "[center]%s[/center]" % score
	goal_b.play()

func apply_damage() -> void:
	health -= 1
	health_ui.text = "[center]%s[/center]" % health

func instantiate_ball() -> void:
	var ball_instance: CharacterBody2D = ball.instantiate()
	ball_instance.paddle_node = paddle
	ball_instance.position = Vector2(320, 300)
	
	game.add_child(ball_instance)

func update_score(player_scoring: int) -> void:
	if player_scoring < 0:
		# p2_score += 1
		health_ui.text = "[center]%s[/center]" % health
		goal_a.play()
	elif player_scoring > 0:
		# p1_score += 1
		score_ui.text = "[center]%s[/center]" % score
		goal_b.play()

func transition_to_menu(menu: Control):
	get_tree().paused = true
	menu.visible = true
	menu.set_process(true)

func play_end_audio(audio: AudioStreamPlayer):
	if !played_end_audio:
		played_end_audio = true
		audio.play()
