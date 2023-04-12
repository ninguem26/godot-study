extends Area2D

func on_body_entered(body: Node2D) -> void:
	body.get_hit(global_position)
