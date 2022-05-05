class_name MoveState
extends BaseState

export(NodePath) var run_node
export(NodePath) var idle_node
export(NodePath) var dash_node

#onready var run_state: BaseState = get_node(run_node)
onready var idle_state: BaseState = get_node(idle_node)
#onready var dash_state: BaseState = get_node(dash_node)

func input(_event: InputEvent) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	var new_state = move()
	player.velocity = player.move_and_slide(player.velocity, Vector2.ZERO)
	
	return new_state

func move() -> BaseState:
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = input_dir("Right", "Left")
	
	if input_vector.x != 0:
		player.velocity.x = lerp(player.velocity.x, player.walk_speed * input_vector.x, player.acceleration)
	else:
		return idle_node
	
	return self

func input_dir(first_input: String, second_input: String) -> float:
	var input_1: float = Input.get_action_strength(first_input)
	var input_2: float = Input.get_action_strength(second_input)
	
	return input_1 - input_2
