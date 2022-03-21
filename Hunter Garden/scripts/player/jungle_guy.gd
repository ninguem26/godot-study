extends KinematicBody2D

const SMOKEFX = preload("res://scenes/effects/smoke_fx.tscn")
const DASHFX = preload("res://scenes/effects/dash_fx.tscn")
const SPELL = preload("res://scenes/player/spell.tscn")

var velocity: Vector2
var dash_direction: Vector2

var jump_count: int = 0
var spell_spawner_position_x: int = 18

var can_attack: bool = true

var can_dash: bool = false
var is_dashing: bool = false

export(int) var walk_speed
export(int) var jump_speed
export(int) var gravity
export(int) var idle_threshold
export(int) var dash_speed

export(float) var acceleration
export(float) var friction
export(float) var dash_length
export(float) var attack_cooldown

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var dash_timer: Timer = get_node("DashTimer")
onready var dash_particles: Particles2D = get_node("DashParticles")
onready var attack_timer: Timer = get_node("AttackTimer")
onready var spell_spawner: Position2D = get_node("SpellSpawner")

func _ready() -> void:
	attack_timer.set_wait_time(attack_cooldown)

func _physics_process(delta: float) -> void:
	move()
	attack()
	handle_dash()
	animate()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	jump()

func move() -> void:
	var input_vector: Vector2 = Vector2.ZERO	
	input_vector.x = input_dir("Right", "Left")
	
	if input_vector.x != 0:
		velocity.x = lerp(velocity.x, walk_speed * input_vector.x, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func jump() -> void:
	if is_on_floor() and jump_count != 0:
		spawn_dust_effect()
		jump_count = 0
		can_dash = false
	
	if Input.is_action_just_pressed("Jump") and jump_count < 2:
		jump_count += 1
		velocity.y = -jump_speed
		can_dash = true

func animate() -> void:
	change_direction()
	
	if velocity.y != 0:
		jump_animation()
	else:
		move_animation()

func change_direction() -> void:
	if velocity.x > 0:
		spell_spawner.position.x = spell_spawner_position_x
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		spell_spawner.position.x = -spell_spawner_position_x
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

func handle_dash() -> void:
	if Input.is_action_just_pressed("Dash") and can_dash and not is_on_floor():
		is_dashing = true
		can_dash = false
		dash_direction = dash()
		dash_timer.start(dash_length)
	
	if is_dashing:
		dash_particles.emitting = true
		spawn_dash_effect()
		dash_direction = move_and_slide(dash_direction)
		
		if is_on_floor() or is_on_wall():
			is_dashing = false
	else:
		dash_particles.emitting = false

func dash() -> Vector2:
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = input_dir("Right", "Left")
	input_vector.y = input_dir("Down", "Up")
	input_vector = input_vector.clamped(1)
	
	if input_vector == Vector2.ZERO:
		if animated_sprite.flip_h:
			input_vector.x = -1
		else:
			input_vector.x = 1
	
	return input_vector * dash_speed

func on_dash_timeout() -> void:
	is_dashing = false

func input_dir(first_input: String, second_input: String) -> float:
	var input_1: float = Input.get_action_strength(first_input)
	var input_2: float = Input.get_action_strength(second_input)
	
	return input_1 - input_2

func spawn_dash_effect() -> void:
	var dash: Object = DASHFX.instance()
	
	dash.texture = animated_sprite.frames.get_frame(animated_sprite.animation, animated_sprite.frame)
	dash.global_position = global_position
	dash.flip_h = animated_sprite.flip_h
	get_tree().root.call_deferred("add_child", dash)

func attack() -> void:
	if Input.is_action_just_pressed("Attack") and can_attack:
		var spell: Object = SPELL.instance()
		
		spell.global_position = spell_spawner.global_position
		spell.direction = sign(spell_spawner.position.x)
		
		get_tree().root.call_deferred("add_child", spell)
		
		attack_timer.start()
		can_attack = false

func on_attack_timeout():
	can_attack = true
