extends Node

signal change_current_state(new_state)

export(NodePath) var start_state

var current_state: BaseState
var previous_state: BaseState

func init(player: Player) -> void:
	for child in get_children():
		child.player = player
	
	change_state(get_node(start_state))

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	
	if new_state:
		change_state(new_state)

func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	
	if new_state:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	
	if new_state:
		change_state(new_state)

func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()
	
	previous_state = current_state
	current_state = new_state
	current_state.enter()
	
	emit_signal("change_current_state", current_state.name)
