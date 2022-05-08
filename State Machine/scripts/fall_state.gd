extends BaseState

export(int) var speed = 150
export(int) var jump_speed = 150
export(float) var gravity = 0.9

export(NodePath) var idle_node
export(NodePath) var run_node
export(NodePath) var walk_node
export(NodePath) var dash_node

onready var idle_state: BaseState = get_node(idle_node)
onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(_event: InputEvent) -> BaseState:
	return null

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	print('caindo')
	return move()

func move() -> BaseState:
	var direction = input_dir()
	
	player.velocity.y = lerp(player.velocity.y, jump_speed, gravity)
	player.velocity.x = lerp(player.velocity.x, speed * direction, player.acceleration)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.is_on_floor():
		if direction != 0:
			if Input.is_action_pressed('mod_shift'):
				return run_state
			
			return walk_state
		else:
			return idle_state
		
	return null
