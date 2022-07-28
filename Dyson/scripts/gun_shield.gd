extends KinematicBody2D

export(NodePath) var pivot_node

export(float) var speed = 30.0
export(float) var acceleration = 1.0

onready var pivot: StaticBody2D = get_node(pivot_node)

var velocity: Vector2
var pivot_point: Vector2

var current_angle: float = 0.0

func _ready() -> void:
	pivot_point = pivot.global_position
	
func _physics_process(delta: float) -> void:
	move(input_dir())

func rotated_point(angle, distance):
	return pivot_point + Vector2(sin(angle),cos(angle)) * distance

func move(direction: int) -> void:
	var distance: float = pivot_point.distance_to(global_position)
	var angular_speed: float = speed/distance
	
	current_angle += angular_speed*direction
	position = rotated_point(current_angle, distance)
	look_at(pivot_point)

func input_dir() -> int:
	if Input.is_action_pressed('ui_left'):
		return -1
	elif Input.is_action_pressed('ui_right'):
		return 1
	return 0
