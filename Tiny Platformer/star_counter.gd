extends NinePatchRect

@onready var label: Label = $Label

func _ready() -> void:
	set_label_text()
	EventBus.connect('on_collected_item', on_item_collected)

func on_item_collected(value: int) -> void:
	GameManager.score += value
	set_label_text()

func set_label_text() -> void:
	label.text = str(GameManager.score)
