class_name Ball
extends CharacterBody2D

@onready var knock_paddle: AudioStreamPlayer = $AudioEffects/KnockPaddle
@onready var knock_wall: AudioStreamPlayer = $AudioEffects/KnockWall

var window_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var paddle_node: Paddle

var dir: Vector2 = Vector2(1, 1).normalized()
var speed: float = 150.0
var speed_mod: float
var margin_bottom: int = 352
var can_move: bool = false

var force_denominator: int = 40

func _ready() -> void:
	calculate_speed_modifier(dir)

func _physics_process(_delta: float) -> void:
	velocity = dir * (speed + (speed * speed_mod))
	print(dir)
	
	if paddle_node != null && !can_move:
		global_position = paddle_node.ball_respawn.global_position
		
		if Input.is_action_just_pressed('launch'):
			can_move = true
			dir = Vector2.UP
			calculate_speed_modifier(dir)
		else:
			return
	
	if can_move:
		move_and_slide()
		
		if global_position.y >= margin_bottom:
			destroy()
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	
	if collision != null:
		var normal: Vector2 = collision.get_normal()
		
		if normal.x != 0:
			dir.x *= -1
		
		if normal.y != 0:
			dir.y *= -1
		
		if collision.get_collider() is CharacterBody2D:
			handle_paddle_collision(collision.get_collider())
		else:
			knock_wall.play()

func destroy() -> void:
	EventBus.on_ball_destruction.emit()
	queue_free()

func on_area_body_entered(body: Node2D) -> void:
	if body is Block:
		body.get_hit()
	elif body is Paddle:
		speed *= 1.05

func handle_paddle_collision(paddle: CharacterBody2D) -> void:
	var start_pos: Vector2 = paddle.global_position
	var end_pos: Vector2 = global_position
	var new_dir: Vector2 = Vector2(end_pos.x - start_pos.x, end_pos.y - start_pos.y)
	
	calculate_speed_modifier(new_dir)
	dir = new_dir.normalized()
	knock_paddle.play()

func calculate_speed_modifier(direction: Vector2) -> void:
	speed_mod = abs(cos(direction.angle_to(Vector2(1, 0))))
