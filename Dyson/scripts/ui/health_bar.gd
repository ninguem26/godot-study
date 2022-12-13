extends RichTextLabel

func on_update_health_bar(health: float) -> void:
	text = str("Vida: ", health)
