extends Node2D

export(Array, NodePath) var connections

onready var sprite = get_node('Sprite')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func mark() -> void:
	sprite.modulate = Color(0, 1, 0)

func unmark() -> void:
	sprite.self_modulate = Color(255, 255, 255)
