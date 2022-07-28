extends Area2D

func on_body_entered(body: Node) -> void:
	if body is Player:
		print('Pode flutuar')
