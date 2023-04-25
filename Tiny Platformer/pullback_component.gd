class_name PullbackComponent
extends Node

var target: PhysicsBody2D

var is_invincible: bool = false

var magnitude: int = 300
var invincibility_cooldown: float = 2

var invincibility_cooldown_timer: SceneTreeTimer

func _ready():
	start_timer(0)

func apply_force(base_position: Vector2):
	# effect_player.play('hit')
	target.set_collision_layer_value(5, false)
	is_invincible = true
	start_timer(invincibility_cooldown)
	target.velocity = -target.global_position.direction_to(base_position) * magnitude

func reset_invincibility_cooldown_timer() -> void:
	is_invincible = false
	target.set_collision_layer_value(5, true)

func start_timer(duration: float):
	invincibility_cooldown_timer = get_tree().create_timer(duration)
	invincibility_cooldown_timer.connect("timeout", reset_invincibility_cooldown_timer)
