extends CharacterBody2D

@onready var knock_paddle: AudioStreamPlayer = $AudioEffects/KnockPaddle
@onready var knock_wall: AudioStreamPlayer = $AudioEffects/KnockWall

var window_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var speed: Vector2 = Vector2(150.0, 150.0)
var margin_size: int = 64
var can_move: bool = false

func _ready() -> void:
	visible = false

func _physics_process(_delta: float) -> void:
	velocity = speed
	
	if can_move:
		move_and_slide()
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	
	if collision != null:
		var normal: Vector2 = collision.get_normal()
		
		if normal.x != 0:
			speed.x *= -1
		
		if normal.y != 0:
			speed.y *= -1
		
		if collision.get_collider() is CharacterBody2D:
			knock_paddle.play()
		else:
			knock_wall.play()

func destroy(new_ball_dir: int) -> void:
	EventBus.goal_scored.emit(new_ball_dir)
	queue_free()

func on_area_body_entered(body: Node2D) -> void:
	if body.name == "Paddle":
		speed *= 1.05

func on_timer_timeout() -> void:
	visible = true
	can_move = true
