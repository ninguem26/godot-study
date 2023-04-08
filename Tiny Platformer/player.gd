extends CharacterBody2D

@export var acceleration: float = 0.5
@export var friction: float = 0.75
@export var jump_offset: float = 0.1

@export var move_speed: float = 120.0
@export var jump_velocity: float = -300.0
@export var jump_release_velocity: float = -75.0
@export var gravity: float = 980.0

var current_direction: int = 1

var jump_offset_timer: SceneTreeTimer
var in_jump_offset: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	jump_offset_timer = get_tree().create_timer(jump_offset)
	jump_offset_timer.connect("timeout", reset_jump_offset_timer)
	
	animation_player.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir: int = int(input_dir(InputKeys.MOVE_RIGHT, InputKeys.MOVE_LEFT))
	
	if dir:
		if dir != 0 and dir != current_direction:
			current_direction = dir
			scale.x *= -1
		
		animation_player.play("run")
		velocity.x = lerp(velocity.x, move_speed * dir, acceleration)
	else:
		if is_on_floor():
			animation_player.play("idle")
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

	move_and_slide()

func reset_jump_offset_timer():
	in_jump_offset = false

func input_dir(first_input: String, second_input: String) -> float:
	var input_1: float = Input.get_action_strength(first_input)
	var input_2: float = Input.get_action_strength(second_input)
	
	return input_1 - input_2

func on_screen_exited():
	queue_free()

func handle_death():
	get_tree().change_scene_to_file('res://scene_transition.tscn')
	queue_free()
