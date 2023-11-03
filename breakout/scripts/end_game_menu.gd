extends Control

@onready var title: RichTextLabel = $VBoxContainer/Title

func _ready() -> void:
	set_process(false)

func set_game_over_screen():
	title.text = '[center][b]GAME OVER[/b][/center]'

func set_game_won_screen():
	title.text = '[center][b]YOU WIN![/b][/center]'

func on_start_new_button_button_up() -> void:
	resume()
	get_tree().change_scene_to_file('res://nodes/main.tscn')

func on_quit_button_button_up() -> void:
	get_tree().quit()

func resume() -> void:
	get_tree().paused = false
	visible = false
	set_process(false)
