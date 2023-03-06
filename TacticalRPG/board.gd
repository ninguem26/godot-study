class_name Board
extends Node

export var highlight_radius: int = 1
export var cell_size: int = 64
export var max_board_size: Vector2 = Vector2(3, 4)

var selected_cell: Cell
var selected_connections: Array = []

var picked_cell: Cell

onready var cells: Array = get_node('Cells').get_children()
onready var board_matrix: Array = init_board_matrix()

func _process(_delta: float) -> void:
	if selected_cell != null:
		unmark_all()
	
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var board_position: Vector2 = pos2coord(mouse_pos)
	
	selected_cell = get_cell_on_board(board_position)

	if picked_cell != null:
		mark_all(picked_cell)
	else:
		mark_all(selected_cell)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('mouse_left'):
		pick_and_move()

func positions_in_radius(center: Vector2, radius: int) -> Array:
	var center_position = pos2coord(center)
	var positions: Array = [center_position]
	
	for i in range(radius):
		for j in range(i):
			positions.append(center_position + Vector2(radius-i,j))
			positions.append(center_position + Vector2(-j, radius-i))
			positions.append(center_position + Vector2(j, -(radius-i)))
			positions.append(center_position + Vector2(-(radius-i),-j))
	
	return positions

func show_cell_radius(cell: Cell, color: Color) -> void:
	if not cell.blocked && cell.is_occupied():
		var positions = positions_in_radius(cell.global_position, cell.radius())
		var found_cells = get_cells_on_board(positions)
		
		selected_connections = found_cells
		
		for found_cell in found_cells:
			found_cell.mark(color)
	else:
		cell.mark(color)

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
			unmark_all()
			selected_cell = null

func mark_all(starting_cell: Cell) -> void:
	if starting_cell != null:
		var color: Color = cell_color(starting_cell)
		
		show_cell_radius(starting_cell, color)

func unmark_all() -> void:
	selected_cell.unmark()
	for cell_node in selected_connections:
		cell_node.unmark()
	selected_connections.clear()

func cell_color(cell: Cell) -> Color:
	if cell.blocked || !cell.is_occupied():
		return  Color(0, .5, .5)
	
	return Color(0, 1, 0)

func init_board_matrix() -> Array:
	var matrix: Array = new_matrix(max_board_size.x, max_board_size.y)
	
	for cell in cells:
		var position: Vector2 = (cell.global_position / cell_size).floor()
		matrix[position.y][position.x] = cell
	
	return matrix

func new_matrix(x: int, y: int) -> Array:
	var matrix: Array = []
	matrix.resize(x)
	
	for i in range(x):
		var columns: Array = []
		columns.resize(y)
		
		matrix[i] = columns
	
	return matrix

func is_inside_board(coordinates: Vector2) -> bool:
	if coordinates.x < max_board_size.y && coordinates.x >= 0:
		if coordinates.y < max_board_size.x && coordinates.y >= 0:

			return true
	
	return false

func get_cell_on_board(coordinate: Vector2) -> Cell:
	if is_inside_board(coordinate):
		return board_matrix[coordinate.y][coordinate.x]
	
	return null

func get_cells_on_board(coordinates: Array) -> Array:
	var board_cells: Array = []
	
	for coordinate in coordinates:
		var cell = get_cell_on_board(coordinate)
		
		if cell != null && not cell.blocked:
			board_cells.append(cell)
	
	return board_cells

func pos2coord(position: Vector2) -> Vector2:
	return (position / cell_size).floor()
