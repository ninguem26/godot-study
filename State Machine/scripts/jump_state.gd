extends BaseState

export(int) var jump_speed = 150
export(float) var gravity = 9.8

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(_event: InputEvent) -> BaseState:
	return null

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return null
