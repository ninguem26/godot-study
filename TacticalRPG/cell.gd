extends Node2D

export(Array, NodePath) var connections

onready var sprite = get_node('Sprite')
var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func mark() -> void:
	if !selected:
		sprite.modulate = Color(0, 1, 0)
		selected = true

func unmark() -> void:
	sprite.modulate = Color(1, 1, 1)
	selected = false
