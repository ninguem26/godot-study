class_name MoveState
extends BaseState

export(int) var speed = 150

export(NodePath) var run_node
export(NodePath) var idle_node
export(NodePath) var walk_node
export(NodePath) var dash_node
export(NodePath) var fall_node
export(NodePath) var jump_node

onready var run_state: BaseState = get_node(run_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var jump_state: BaseState = get_node(jump_node)

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('Dash'):
		return dash_state
	elif Input.is_action_just_pressed('Jump'):
		return jump_state
	
	return null

func physics_process(_delta: float) -> BaseState:
	return move()

func move() -> BaseState:
	if !player.is_on_floor():
		return fall_state
	
	var direction = input_dir()
	
	player.velocity.y += player.gravity
	player.velocity.x = lerp(player.velocity.x, speed * direction, player.acceleration)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if direction == 0:
		return idle_state
	
	return null
