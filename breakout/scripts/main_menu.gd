extends Node

@onready var main_menu: Control = get_node('Control')
@onready var options_menu: Control = get_node('OptionsMenu')

func on_start_button_button_up() -> void:
	get_tree().change_scene_to_file('res://nodes/main.tscn')

func on_options_button_button_up() -> void:
	main_menu.visible = false
	main_menu.set_process(false)
	options_menu.visible = true
	options_menu.set_process(true)

func on_quit_button_button_up() -> void:
	get_tree().quit()
