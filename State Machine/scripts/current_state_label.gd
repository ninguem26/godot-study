extends RichTextLabel

func _on_change_current_state(new_state: String) -> void:
	text = new_state
