class_name MoveState
extends BaseState

export(int) var speed = 150

export(NodePath) var run_node
export(NodePath) var idle_node
export(NodePath) var walk_node
export(NodePath) var dash_node

onready var run_state: BaseState = get_node(run_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
#onready var dash_state: BaseState = get_node(dash_node)

func input(_event: InputEvent) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return move()

func move() -> BaseState:
	var direction = input_dir()
	
	player.velocity.x = lerp(player.velocity.x, speed * direction, player.acceleration)
	player.velocity = player.move_and_slide(player.velocity, Vector2.ZERO)
	
	if direction == 0:
		return idle_state
	
	return null

func input_dir() -> int:
	if Input.is_action_pressed('Left'):
		return -1
	elif Input.is_action_pressed('Right'):
		return 1
	
	return 0
