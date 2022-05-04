extends BaseState

export(NodePath) var run_node
export(NodePath) var walk_node
export(NodePath) var dash_node

onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)
