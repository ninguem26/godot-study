extends CharacterBody2D

@export var ball: CharacterBody2D

const SPEED = 500.0

func _physics_process(delta: float) -> void:
	if ball != null && ball.speed.x > 0:
		velocity = velocity.lerp(move_direction() * SPEED, delta)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func move_direction() -> Vector2:
	if ball == null:
		return Vector2.ZERO
	
	var distance: float = ball.position.y - position.y
	
	return Vector2(0, distance / abs(distance))
