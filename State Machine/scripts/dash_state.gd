extends MoveState

export(float) var dash_time = 0.4

var player_gravity: float
var current_dash_time: float

func enter() -> void:
	current_dash_time = dash_time

func input(_event: InputEvent) -> BaseState:
	return null

func move() -> BaseState:
	var direction = input_dir()
	
	player.velocity.y = 0
	player.velocity.x = lerp(player.velocity.x, speed * direction, player.acceleration)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	return null

func process(delta: float) -> BaseState:
	current_dash_time -= delta
	
	if current_dash_time > 0:
		return null
	
	if !player.is_on_floor():
		return fall_state
	
	if Input.is_action_pressed('Left') or Input.is_action_pressed('Right'):
		if Input.is_action_pressed('mod_shift'):
			return run_state
		
		return walk_state
	
	return idle_state

func input_dir() -> int:
	return player.dir
