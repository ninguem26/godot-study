extends Control

@export var options_menu: Control

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_cancel'):
		resume()

func on_resume_button_button_up() -> void:
	resume()

func on_restart_button_button_up() -> void:
	resume()
	get_tree().change_scene_to_file('res://nodes/main.tscn')

func on_options_button_button_up() -> void:
	visible = false
	set_process(false)
	options_menu.visible = true
	options_menu.set_process(true)

func on_quit_button_button_up() -> void:
	get_tree().quit()

func resume() -> void:
	get_tree().paused = false
	visible = false
	set_process(false)
