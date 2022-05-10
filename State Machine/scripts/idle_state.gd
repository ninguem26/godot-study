extends BaseState

export(NodePath) var run_node
export(NodePath) var walk_node
export(NodePath) var dash_node
export(NodePath) var fall_node
export(NodePath) var jump_node

onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var jump_state: BaseState = get_node(jump_node)

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('Dash'):
		return dash_state
	elif Input.is_action_just_pressed('Jump'):
		return jump_state
	
	if Input.is_action_pressed('Left') or Input.is_action_pressed('Right'):
		if Input.is_action_pressed('mod_shift'):
			return run_state
		
		return walk_state
	
	return null

func physics_process(_delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state
	
	player.velocity.x = lerp(player.velocity.x, 0, player.friction)
	
	return null
