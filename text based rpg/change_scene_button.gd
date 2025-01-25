extends Button

@export_file var scene_file: String

func _on_button_up() -> void:
	get_tree().change_scene_to_file(scene_file)
