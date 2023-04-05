extends NinePatchRect

@onready var label: Label = $Label

func _ready():
	set_label_text()
	EventBus.connect('on_collected_item', on_item_collected)

func on_item_collected(value: int):
	GameManager.score += value
	set_label_text()

func set_label_text():
	label.text = str(GameManager.score)
