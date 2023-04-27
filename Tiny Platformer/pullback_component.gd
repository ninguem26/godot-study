class_name PullbackComponent
extends Node

@export var target: PhysicsBody2D
@export var layers: Array[int]
@export var magnitude: int = 300
@export var invincibility_cooldown: float = 2
@export var input_response_cooldown: float = 0.25
@export var can_be_invicible: bool = true

var is_invincible: bool = false

var invincibility_cooldown_timer: SceneTreeTimer

func _ready():
	start_timer(0)

func apply_force(base_position: Vector2, effect = null):
	if effect != null:
		effect.call()
	
	if can_be_invicible:
		set_layers(false)
		is_invincible = true
	
	start_timer(invincibility_cooldown)
	target.velocity = -target.global_position.direction_to(base_position) * magnitude

func reset_invincibility_cooldown_timer() -> void:
	is_invincible = false
	set_layers(true)

func start_timer(duration: float):
	invincibility_cooldown_timer = get_tree().create_timer(duration)
	invincibility_cooldown_timer.connect("timeout", reset_invincibility_cooldown_timer)

func has_started() -> bool:
	return invincibility_cooldown_timer.time_left > 0

func can_move() -> bool:
	return invincibility_cooldown_timer.time_left < (invincibility_cooldown - input_response_cooldown)

func set_layers(is_active: bool) -> void:
	for layer in layers:
		target.set_collision_layer_value(layer, is_active)
