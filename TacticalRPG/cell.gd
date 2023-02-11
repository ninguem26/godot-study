extends Node2D

export(Array, NodePath) var connections_path

onready var sprite: Sprite = get_node('Sprite')
onready var label: Label = get_node('Label')
onready var connections: Array = init_connections()
var selected: bool = false

func _ready() -> void:
	label.text = name

func mark() -> void:
	if !selected:
		sprite.modulate = Color(0, 1, 0)
		selected = true

func unmark() -> void:
	sprite.modulate = Color(1, 1, 1)
	selected = false

func init_connections() -> Array:
	var connections_node: Array = []
	for connection in connections_path:
		connections_node.append(get_node(connection))
	
	return connections_node
