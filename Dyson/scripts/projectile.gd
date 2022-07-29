extends Area2D

export(float) var speed = 30.0

func _physics_process(delta: float):
	translate(Vector2(-speed*delta, 0))

func on_screen_exited():
	queue_free()
