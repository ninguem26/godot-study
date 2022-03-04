extends ParallaxBackground

export(Array, int) var layer_speed
export(bool) var can_move_layer

func _physics_process(delta: float) -> void:
	if can_move_layer:
		var index: int = 0
		
		for parallax_layer in get_children():
			parallax_layer.motion_offset.x -= layer_speed[index] * delta
			index += 1
