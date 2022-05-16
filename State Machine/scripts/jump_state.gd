extends BaseState

export(int) var speed = 150
export(float) var jump_speed = 150

export(NodePath) var idle_node
export(NodePath) var run_node
export(NodePath) var walk_node
export(NodePath) var dash_node
export(NodePath) var fall_node

onready var idle_state: BaseState = get_node(idle_node)
onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)
onready var fall_state: BaseState = get_node(fall_node)

var current_jump_speed: float

func enter() -> void:
	current_jump_speed = jump_speed

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('Dash'):
		return dash_state
	
	if Input.is_action_just_released('Jump'):
		return fall_state
	
	return null

func physics_process(_delta: float) -> BaseState:
	return move()

func move() -> BaseState:
	if current_jump_speed <= 0:
		return fall_state
	
	var direction = input_dir()
	
	player.velocity.y = -current_jump_speed
	player.velocity.x = lerp(player.velocity.x, speed * direction, player.acceleration)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	current_jump_speed -= player.gravity
	
	return null
