extends KinematicBody2D

const SMOKEFX = preload("res://scenes/effects/smoke_fx.tscn")

var velocity: Vector2

var jump_count: int = 0

export(int) var walk_speed
export(int) var jump_speed
export(int) var gravity
export(int) var idle_threshold

export(float) var acceleration
export(float) var friction

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

func _physics_process(delta: float) -> void:
	move()
	animate()
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
	if is_on_floor() and jump_count != 0:
		spawn_dust_effect()
		jump_count = 0
	
	if Input.is_action_just_pressed("Jump") and jump_count < 2:
		jump_count += 1
		velocity.y = -jump_speed

func animate() -> void:
	change_direction()
	
	if velocity.y != 0:
		jump_animation()
	else:
		move_animation()

func change_direction() -> void:
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
	
func jump_animation() -> void:
	if velocity.y > 0:
		animated_sprite.play("Fall")
	elif velocity.y < 0:
		animated_sprite.play("Jump")

func move_animation() -> void:
	if abs(velocity.x) > idle_threshold:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")

func spawn_dust_effect() -> void:
	var dust: Object = SMOKEFX.instance()
	
	get_tree().root.call_deferred("add_child", dust)
	dust.global_position = global_position + Vector2(0, 1)
