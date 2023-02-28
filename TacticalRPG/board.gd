class_name Board
extends Node

export var highlight_radius: int = 1
export var cell_size: float = 64.0

var selected_cell: Cell
var selected_connections: Array = []

var picked_cell: Cell

onready var cells: Array = get_children()

func _process(_delta: float) -> void:
	if selected_cell != null:
		unmark_all()
	
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	selected_cell = find_cell_by_position(mouse_pos)
	
	if picked_cell != null:
		mark_all(picked_cell)
	else:
		mark_all(selected_cell)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('mouse_left'):
		pick_and_move()

func find_cell_by_position(position) -> Cell:
	var cell_offset: Vector2 = Vector2(cell_size / 2, cell_size / 2)
	var cell_position: Vector2 = ((position / cell_size).floor() * cell_size) + cell_offset
	
	for cell in cells:
		if cell.position.x == cell_position.x:
			if cell.position.y == cell_position.y:
				return cell
	
	return null

func show_cell_radius(around_cells: Array, radius: int, color: Color) -> void:
	if !around_cells.empty() && radius >= 1:
		var next_cells: Array = []
		
		for cell in around_cells:
			if cell.is_available():
				cell.mark(color)
				selected_connections.append(cell)
				next_cells.append_array(cell.connections)
		
		show_cell_radius(next_cells, radius - 1, color)

func pick_and_move() -> void:
	if picked_cell == selected_cell:
		picked_cell = null
	else:
		if picked_cell:
			picked_cell.unmark()
			move_contained_object()
		picked_cell = selected_cell

func move_contained_object() -> void:
	if picked_cell.is_occupied():
		if selected_connections.has(selected_cell):
			var object: Node2D = picked_cell.contained_object
			selected_cell.contained_object = object
			object.move_to(selected_cell.global_position)
			picked_cell.contained_object = null
			selected_cell = null

func mark_all(starting_cell: Cell) -> void:
	if starting_cell != null:
		var color: Color = cell_color(starting_cell)
		starting_cell.mark(color)
		
		if not starting_cell.blocked && starting_cell.is_occupied():
			show_cell_radius(starting_cell.connections, starting_cell.contained_object.reach_radius, color)

func unmark_all() -> void:
	selected_cell.unmark()
	for cell_node in selected_connections:
		cell_node.unmark()
	selected_connections.clear()

func cell_color(cell: Cell) -> Color:
	if cell.blocked || !cell.is_occupied():
		return  Color(0, .5, .5)
	
	return Color(0, 1, 0)
