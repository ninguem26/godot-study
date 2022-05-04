class_name BaseState
extends Node

var player: Object

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(_event: InputEvent) -> BaseState:
	return null

func process(_delta: float) -> BaseState:
	return null

func init(new_player: Object) -> void:
	player = new_player

func physics_process(_delta: float) -> void:
	move()
	player.velocity = player.move_and_slide(player.velocity, Vector2.ZERO)

func move() -> void:
	var input_vector: Vector2 = Vector2.ZERO	
	input_vector.x = input_dir("Right", "Left")
	
	if input_vector.x != 0:
		player.velocity.x = lerp(player.velocity.x, player.walk_speed * input_vector.x, player.acceleration)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.friction)

func input_dir(first_input: String, second_input: String) -> float:
	var input_1: float = Input.get_action_strength(first_input)
	var input_2: float = Input.get_action_strength(second_input)
	
	return input_1 - input_2
