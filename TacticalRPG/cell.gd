class_name Cell
extends Node2D

export(NodePath) var contained_object_path

export(bool) var blocked = false

onready var sprite: Sprite = get_node('Sprite')
onready var label: Label = get_node('Label')

var contained_object: Object

var selected: bool = false

func _ready() -> void:
	label.text = name
	if not contained_object_path.is_empty():
		contained_object = get_node(contained_object_path)

func mark(color: Color) -> void:
	if !selected:
		sprite.modulate = color
		selected = true

func unmark() -> void:
	sprite.modulate = Color(1, 1, 1)
	selected = false

func is_available() -> bool:
	return not selected && not blocked

func is_occupied() -> bool:
	return contained_object != null && contained_object.is_class('Node2D')

func radius() -> int:
	if is_occupied(): return contained_object.reach_radius
	
	return 1

func get_class() -> String:
	return 'Cell'
