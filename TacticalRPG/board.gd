extends Node

export var highlight_radius: int = 1
export var cell_size: int = 64

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

func show_cell_radius(cell, radius) -> void:
	print(cell)
	print(cell.connections)
	if radius >= 1:
		for cell_node in cell.connections:
			if !cell_node.selected:
				cell_node.mark()
				show_cell_radius(cell_node, radius - 1)
				selected_connections.append(cell_node)

func mark_all(starting_cell) -> void:
	if starting_cell != null:
		starting_cell.mark()
		show_cell_radius(starting_cell, highlight_radius)

func unmark_all() -> void:
	selected_cell.unmark()
	for cell_node in selected_connections:
		cell_node.unmark()
	selected_connections.clear()
