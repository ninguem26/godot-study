class_name BaseState
extends Node

var player: Player

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

func input_dir() -> int:
	if Input.is_action_pressed('Left'):
		player.dir = -1
		
		return player.dir
	elif Input.is_action_pressed('Right'):
		player.dir = 1
		
		return player.dir
	
	return 0
