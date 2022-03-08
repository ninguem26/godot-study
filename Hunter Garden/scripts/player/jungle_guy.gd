extends KinematicBody2D

var velocity: Vector2
var jump_count: int = 0

export(int) var walk_speed
export(int) var jump_speed
export(int) var gravity

export(float) var acceleration
export(float) var friction

func _physics_process(delta: float) -> void:
	move()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	jump()

func move() -> void:
	var input_vector: Vector2 = Vector2.ZERO
	
	var input_left: float = Input.get_action_strength("Left")
	var input_right: float = Input.get_action_strength("Right")
	
	input_vector.x = input_right - input_left
	
	if input_vector.x != 0:
		velocity.x = lerp(velocity.x, walk_speed * input_vector.x, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func jump() -> void:
	if is_on_floor():
		jump_count = 0
	
	if Input.is_action_just_pressed("Jump") and jump_count < 2:
		jump_count += 1
		velocity.y = -jump_speed
