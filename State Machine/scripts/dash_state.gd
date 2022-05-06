extends MoveState

export(float) var dash_time = 0.4

var current_dash_time: float

func enter() -> void:
	current_dash_time = dash_time

func input(_event: InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	current_dash_time -= delta
	
	if current_dash_time > 0:
		return null
	
	if Input.is_action_pressed('Left') or Input.is_action_pressed('Right'):
		if Input.is_action_pressed('mod_shift'):
			return run_state
		
		return walk_state
	
	return idle_state

func input_dir() -> int:
	return player.dir
