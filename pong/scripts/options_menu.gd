extends Control

@export var previous_menu: Control

func _ready() -> void:
	visible = false
	set_process(false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_cancel'):
		visible = false
		set_process(false)
		previous_menu.visible = true
		previous_menu.set_process(true)

func on_full_screen_check_box_button_up() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
