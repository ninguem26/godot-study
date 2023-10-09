extends CharacterBody2D

var speed: Vector2 = Vector2(150.0, 150.0)

func _physics_process(delta: float) -> void:
	velocity = speed

	move_and_slide()
	var collision: KinematicCollision2D = get_last_slide_collision()

	if collision != null:
		var normal: Vector2 = collision.get_normal()

		if normal.x != 0:
			speed.x *= -1

		if normal.y != 0:
			speed.y *= -1

func on_area_body_entered(body: Node2D) -> void:
	if body.name == "Paddle":
		speed *= 1.05
