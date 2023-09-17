class_name Player
extends CharacterBody2D

@export var acceleration: float = 0.5
@export var air_friction: float = 0.1
@export var friction: float = 0.75:
	get:
		if is_on_floor():
			return friction
		else:
			return air_friction
@export var jump_offset: float = 0.1

@export var move_speed: float = 120.0
@export var jump_velocity: float = -300.0
@export var jump_release_velocity: float = -75.0
@export var gravity: float = 980.0

var damagged: bool = false

var current_direction: int = 1

var in_jump_offset: bool = false

# Timers
var jump_offset_timer: SceneTreeTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_player: AnimationPlayer = $EffectPlayer
@onready var health_component: HealthComponent = $HealthComponent
@onready var pullback_component: PullbackComponent = $PullbackComponent

func _ready() -> void:
	jump_offset_timer = get_tree().create_timer(jump_offset)
	jump_offset_timer.connect("timeout", reset_jump_offset_timer)

	reset_animation()

func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir: int = int(input_dir(InputKeys.MOVE_RIGHT, InputKeys.MOVE_LEFT))

	if not pullback_component.is_invincible:
		if dir:
			if dir != 0 and dir != current_direction:
				current_direction = dir
				scale.x *= -1

			animation_player.play("run")
			velocity.x = lerp(velocity.x, move_speed * dir, acceleration)
		else:
			if is_on_floor():
				reset_animation()

			velocity.x = lerp(velocity.x, 0.0, friction)

		# Handle Jump.
		if Input.is_action_just_pressed(InputKeys.JUMP):
			in_jump_offset = true
			jump_offset_timer = get_tree().create_timer(jump_offset)
		if Input.is_action_just_released(InputKeys.JUMP):
			if velocity.y < jump_release_velocity:
				velocity.y = jump_release_velocity

		if is_on_floor() and in_jump_offset and jump_offset_timer.get_time_left() > 0:
			animation_player.play("jump")
			velocity.y = jump_velocity
			in_jump_offset = false
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.05)

		if is_on_floor() && pullback_component.can_move():
			pullback_component.is_invincible = false

	move_and_slide()

func reset_jump_offset_timer() -> void:
	in_jump_offset = false

func input_dir(first_input: String, second_input: String) -> float:
	var input_1: float = Input.get_action_strength(first_input)
	var input_2: float = Input.get_action_strength(second_input)

	return input_1 - input_2

func on_screen_exited() -> void:
	if global_position.y > 216:
		handle_death()

func handle_death() -> void:
	SceneTransition.change_scene('res://map.tscn')
	queue_free()

func get_hit(base_position, damage) -> void:
	if not pullback_component.has_started():
		pullback_component.apply_force(base_position, func(): effect_player.play('hit'))
		health_component.current_health -= damage

func reset_animation() -> void:
	animation_player.play('RESET')

func on_health_down_to_zero() -> void:
	handle_death()
