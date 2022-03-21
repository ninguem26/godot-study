extends Sprite

func _physics_process(_delta: float) -> void:
	modulate.a = lerp(modulate.a, 0, 0.1)
	
	if modulate.a < 0.01:
		queue_free()
