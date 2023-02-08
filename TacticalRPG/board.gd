extends Node

var cells
var selected_cell

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

func find_cell_by_position(position) -> Object:
	for cell in cells:
		if cell.position.x == position.x:
			if cell.position.y == position.y:
				return cell
	
	return null

func show_radius(radius) -> void:
	pass
