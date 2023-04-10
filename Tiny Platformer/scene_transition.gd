extends CanvasLayer

func change_scene(target: String) -> void:
	print('nova cena')
	$AnimationPlayer.play('dissolve')
	await($AnimationPlayer.animation_finished)
	get_tree().change_scene_to_file('res://map.tscn')
	$AnimationPlayer.play_backwards('dissolve')
