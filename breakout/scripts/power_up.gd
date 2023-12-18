class_name PowerUp
extends Area2D

var speed: int = 30

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += speed * delta
