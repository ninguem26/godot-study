extends KinematicBody2D

export(Vector2) var velocity = Vector2.ZERO

export(float) var acceleration = 3.0
export(float) var angular_speed = 2.0
export(float) var max_speed = 3.0
export(float) var current_angle = 0.0

export(float) var max_health = 5.0

export(int) var boundary_quoeficient = 26

onready var boundaries: Vector2 = get_viewport_rect().size

onready var health: float = max_health setget set_health

func _physics_process(delta: float) -> void:
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
	if position.x - boundary_quoeficient > boundaries.x:
		position.x = -(boundary_quoeficient - 1)
	elif position.x + boundary_quoeficient < 0:
		position.x = boundaries.x + (boundary_quoeficient - 1)
	
	if position.y - boundary_quoeficient > boundaries.y:
		position.y = -(boundary_quoeficient - 1)
	elif position.y + boundary_quoeficient < 0:
		position.y = boundaries.y + (boundary_quoeficient - 1)

func hit_by_projectile(damage: int) -> void:
	set_health(health - damage)

func set_health(value: float) -> void:
	health = clamp(value, 0, max_health)
	
	if health <= 0:
		queue_free()
