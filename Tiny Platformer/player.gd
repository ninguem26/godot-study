extends CharacterBody2D

const SPEED: float = 100.0
const JUMP_VELOCITY: float = -300.0
const JUMP_RELEASE_VELOCITY: float = -75.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_direction: int = 1

var jump_offset_timer: SceneTreeTimer

var in_jump_offset = false

# Keys references
var jump_key: String = "ui_accept"
var move_right_key: String = "ui_right"
var move_left_key: String = "ui_left"

@export var jump_offset: float = 0.1

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
	var direction: int = int(Input.get_axis(move_left_key, move_right_key))
	
	if direction:
		if direction != 0 and direction != current_direction:
			current_direction = direction
			scale.x *= -1
		
		animation_player.play("run")
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle Jump.
	if Input.is_action_just_pressed(jump_key):
		in_jump_offset = true
		jump_offset_timer = get_tree().create_timer(jump_offset)
	if Input.is_action_just_released(jump_key):
		if velocity.y < JUMP_RELEASE_VELOCITY:
			velocity.y = JUMP_RELEASE_VELOCITY
	
	if is_on_floor() and in_jump_offset and jump_offset_timer.get_time_left() > 0:
		animation_player.play("jump")
		velocity.y = JUMP_VELOCITY
		in_jump_offset = false

	move_and_slide()

func reset_jump_offset_timer():
	in_jump_offset = false
