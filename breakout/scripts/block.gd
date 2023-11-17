class_name Block
extends StaticBody2D

@export_group('Behaviour')
@export var durability: int = 1
@export var value: int = 10
@export_group('Style')
@export var color: Vector2 = Vector2.ZERO

var current_durability: int

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	sprite.set_region_rect( Rect2(Vector2(32 * color.x, 8 * color.y), Vector2(32, 8)))
	
	current_durability = durability

func _process(_delta: float) -> void:
	pass

func get_hit() -> void:
	current_durability -= 1
	print(current_durability)
	if current_durability <= 0:
		destroy()

func destroy() -> void:
	EventBus.on_block_destruction.emit(durability * value)
	queue_free()
