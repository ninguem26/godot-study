extends Node2D

export(int) var reach_radius = 3

func _ready() -> void:
	pass # Replace with function body.

func move_to(position: Vector2) -> void:
	global_position = position
