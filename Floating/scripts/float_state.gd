extends BaseState

signal jump_before_landing()

export(int) var speed = 150
export(float) var max_fall_speed = 150

export(NodePath) var idle_node
export(NodePath) var run_node
export(NodePath) var walk_node
export(NodePath) var dash_node
export(NodePath) var jump_node
export(NodePath) var fall_node

onready var idle_state: BaseState = get_node(idle_node)
onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)
onready var jump_state: BaseState = get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)

var current_fall_speed: float

var jump_pressed: bool = false

func enter() -> void:
	current_fall_speed = 0

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed('Dash'):
		return dash_state
	elif Input.is_action_just_pressed('Jump'):
		if player.current_jump_counter > 0:
			return jump_state
		else:
			jump_pressed = true
			emit_signal('jump_before_landing')
	elif Input.is_action_just_released('Float'):
		return fall_state
	
	return null

func physics_process(_delta: float) -> BaseState:
	return move()

func move() -> BaseState:
	var direction = input_dir()
	
	player.velocity.y = current_fall_speed
	player.velocity.x = lerp(player.velocity.x, speed * direction, player.acceleration)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	current_fall_speed = calculate_fall_speed()
	
	if player.is_on_floor():
		player.current_jump_counter = player.jump_counter
		
		if jump_pressed:
			return jump_state
		
		if direction != 0:
			if Input.is_action_pressed('mod_shift'):
				return run_state
			
			return walk_state
		else:
			return idle_state
		
	return null

func calculate_fall_speed() -> float:
	current_fall_speed += player.gravity
	
	if current_fall_speed > max_fall_speed:
		return max_fall_speed
	
	return current_fall_speed

func _on_jump_timer_timeout() -> void:
	jump_pressed = false
