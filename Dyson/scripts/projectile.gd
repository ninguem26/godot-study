extends Area2D

export(float) var speed = 30.0

func _physics_process(delta: float):
	var angle = Vector2(cos(rotation), sin(rotation))
	translate(-speed*delta*angle)

func on_screen_exited():
	queue_free()
