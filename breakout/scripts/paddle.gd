class_name Paddle
extends CharacterBody2D

const SPEED = 150.0

@onready var ball_respawn: Marker2D = $BallRespawn

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_ball_position(ball: Ball) -> void:
	ball.global_position = ball_respawn.global_position
