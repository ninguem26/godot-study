class_name Shield
extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var collider: CollisionShape2D = $Collider

func toggle_shield() -> void:
	sprite.visible = !sprite.visible
	collider.call_deferred('set_disabled', !collider.disabled)
