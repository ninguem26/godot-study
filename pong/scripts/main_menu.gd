extends Node

func on_start_button_button_up() -> void:
	get_tree().change_scene_to_file('res://nodes/main.tscn')

func on_options_button_button_up() -> void:
	pass # Replace with function body.

func on_quit_button_button_up() -> void:
	get_tree().quit()
