class_name Board
extends Node

export var highlight_radius: int = 1
export var cell_size: float = 64.0

var selected_cell: Cell
var selected_connections: Array = []

onready var cells: Array = get_children()

func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()

	if selected_cell != null:
		unmark_all()
	
	selected_cell = find_cell_by_position(mouse_pos)
	mark_all(selected_cell)

func find_cell_by_position(position) -> Cell:
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
			if cell.is_available():
				cell.mark()
				selected_connections.append(cell)
				next_cells.append_array(cell.connections)
		
		show_cell_radius(next_cells, radius - 1)

func mark_all(starting_cell) -> void:
	if starting_cell != null:
		starting_cell.mark()
		if not starting_cell.blocked:
			show_cell_radius(starting_cell.connections, highlight_radius)

func unmark_all() -> void:
	selected_cell.unmark()
	for cell_node in selected_connections:
		cell_node.unmark()
	selected_connections.clear()
