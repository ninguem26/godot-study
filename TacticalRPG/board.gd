extends Node

var cells
var selected_cell
var previous_cell

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cells = get_children()

func _process(delta: float) -> void:
	pass

func _input(event) -> void:
	if event.is_action_pressed("mouse_left"):
		if selected_cell != null:
			selected_cell.unmark()
		var target_cell = ((event.position / 64).floor() * 64) + Vector2(32, 32)
		selected_cell = find_cell_by_position(target_cell)
		selected_cell.mark()
		show_cell_radius(selected_cell, 1)

func find_cell_by_position(position) -> Object:
	for cell in cells:
		if cell.position.x == position.x:
			if cell.position.y == position.y:
				return cell
	
	return null

func show_cell_radius(cell, radius) -> void:
	if radius >= 1:
		for connection_cell in cell.conections:
			if !connection_cell.selected:
				connection_cell.mark()
				show_cell_radius(connection_cell, radius - 1)
