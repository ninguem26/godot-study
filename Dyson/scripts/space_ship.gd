extends KinematicBody2D

export(Vector2) var velocity = Vector2.ZERO

export(float) var acceleration = 3.0
export(float) var angular_speed = 2.0
export(float) var max_speed = 3.0
export(float) var current_angle = 0.0

onready var boundaries: Vector2 = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	print(get_viewport_rect().size)
	move(input_dir(), delta)

func input_dir() -> int:
	if Input.is_action_pressed('ui_left'):
		return -1
	elif Input.is_action_pressed('ui_right'):
		return 1
	return 0

func move(direction: int, delta: float) -> void:
	rotate_around(direction)
	
	if Input.is_action_pressed('ui_up'):
		velocity += Vector2(acceleration*delta, 0).rotated(rotation)
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.01)
	
	handle_out_of_viewport()
	position += velocity

func rotate_around(direction: int) -> void:
	current_angle += angular_speed*direction
	rotation_degrees = current_angle

func handle_out_of_viewport() ->void:
	if position.x - 26 > boundaries.x:
		position.x = -25
	elif position.x + 26 < 0:
		position.x = boundaries.x + 25
	
	if position.y - 26 > boundaries.y:
		position.y = -25
	elif position.y + 26 < 0:
		position.y = boundaries.y + 25

func hit_by_projectile(_damage: int) -> void:
	pass
