extends BaseState

export(NodePath) var run_node
export(NodePath) var walk_node
export(NodePath) var dash_node

#onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
#onready var dash_state: BaseState = get_node(dash_node)

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('Left') or Input.is_action_just_pressed('Right'):
		return walk_state
	
	return null

func physics_process(_delta: float) -> BaseState:
	player.velocity.x = lerp(player.velocity.x, 0, player.friction)
	
	return self
