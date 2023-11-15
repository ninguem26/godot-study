class_name Block
extends StaticBody2D

@export var durability: int = 1
@export var value: int = 10

var current_durability: int = durability

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_hit() -> void:
	current_durability -= 1
	
	if current_durability <= 0:
		destroy()

func destroy() -> void:
	EventBus.on_block_destruction.emit(durability * value)
	queue_free()
