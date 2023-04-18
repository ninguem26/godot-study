extends Area2D

var damage: int = 1

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_hit(global_position, damage)
