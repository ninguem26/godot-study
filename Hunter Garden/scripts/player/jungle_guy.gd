extends KinematicBody2D

var velocity: Vector2

export(int) var walk_speed

export(float) var acceleration
export(float) var friction

func _physics_process(_delta: float) -> void:
	move()
	velocity = move_and_slide(velocity)

func move() -> void:
	var input_vector: Vector2 = Vector2.ZERO
	
	var input_left: float = Input.get_action_strength("Left")
	var input_right: float = Input.get_action_strength("Right")
	
	input_vector.x = input_right - input_left
	
	if input_vector.x != 0:
		velocity.x = lerp(velocity.x, walk_speed * input_vector.x, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
