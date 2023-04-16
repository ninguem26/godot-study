extends Area2D

var damage: int = 1

func on_body_entered(body: Node2D) -> void:
	body.get_hit(global_position, damage)
