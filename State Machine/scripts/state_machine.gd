extends Node

enum State {
	Null,
	Run,
	Walk,
	Dash,
	Idle
}

var player: Object

var velocity: Vector2
var acceleration: float = 0.9
var walk_speed: int = 150
var friction: float = 0.8

var current_state = State.Idle

func init(owner: Object) -> void:
	player = owner

func physics_process(_delta: float) -> void:
	move()
	velocity = player.move_and_slide(velocity, Vector2.ZERO)

func move() -> void:
	var input_vector: Vector2 = Vector2.ZERO	
	input_vector.x = input_dir("Right", "Left")
	
	if input_vector.x != 0:
		velocity.x = lerp(velocity.x, walk_speed * input_vector.x, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func input_dir(first_input: String, second_input: String) -> float:
	var input_1: float = Input.get_action_strength(first_input)
	var input_2: float = Input.get_action_strength(second_input)
	
	return input_1 - input_2
