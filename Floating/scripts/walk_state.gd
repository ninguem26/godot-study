extends MoveState

func input(event: InputEvent) -> BaseState:
	var new_state = .input(event)
	
	if new_state:
		return new_state
	
	if Input.is_action_pressed('mod_shift'):
		return run_state
	
	return null
