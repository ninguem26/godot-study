extends Node

export var highlight_radius: int = 1
export var cell_size: float = 64.0

var selected_cell: Node2D
var selected_connections: Array = []

onready var cells = get_children()

func _input(event) -> void:
	if event.is_action_pressed("mouse_left"):
		if selected_cell != null:
			unmark_all()
		
		selected_cell = find_cell_by_position(event.position)
		mark_all(selected_cell)

func find_cell_by_position(position) -> Object:
	var cell_offset: Vector2 = Vector2(cell_size/2, cell_size/2)
	var cell_position: Vector2 = ((position / cell_size).floor() * cell_size) + cell_offset
	
	for cell in cells:
		if cell.position.x == cell_position.x:
			if cell.position.y == cell_position.y:
				return cell
	
	return null

func show_cell_radius(around_cells, radius) -> void:
	if !around_cells.empty() && radius >= 1:
		var next_cells: Array = []
		
		for cell in around_cells:
			if not cell.selected:
				cell.mark()
				selected_connections.append(cell)
				next_cells.append_array(cell.connections)
		
		show_cell_radius(next_cells, radius - 1)

func mark_all(starting_cell) -> void:
	if starting_cell != null:
		starting_cell.mark()
		show_cell_radius(starting_cell.connections, highlight_radius)

func unmark_all() -> void:
	selected_cell.unmark()
	for cell_node in selected_connections:
		cell_node.unmark()
	selected_connections.clear()
