extends KinematicBody2D

const PROJECTILE = preload('res://scenes/projectile.tscn')

export(NodePath) var pivot_node

export(float) var speed = 30.0
export(float) var acceleration = 1.0

onready var pivot: StaticBody2D = get_node(pivot_node)
onready var projectile_position: Position2D = get_node('ProjectilePosition')

var velocity: Vector2
var pivot_point: Vector2

var current_angle: float = PI

func _ready() -> void:
	pivot_point = pivot.global_position

func _physics_process(_delta: float) -> void:
	move(input_dir())

func rotated_point(angle, distance) -> Vector2:
	return pivot_point + Vector2(sin(angle), cos(angle)) * distance

func move(direction: int) -> void:
	var distance: float = pivot_point.distance_to(global_position)
	var angular_speed: float = speed/distance
	
	current_angle -= angular_speed*direction
	position = rotated_point(current_angle, distance)
	look_at(pivot_point)

func input_dir() -> int:
	if Input.is_action_pressed('ui_left'):
		return -1
	elif Input.is_action_pressed('ui_right'):
		return 1
	return 0

func attack() -> void:
	var projectile: Object = PROJECTILE.instance()
	
	projectile.global_position = projectile_position.global_position
	projectile.rotation = rotation
	get_tree().root.call_deferred('add_child', projectile)

func on_attack_timer_timeout() -> void:
	attack()

func hit_by_projectile(_damage: int) -> void:
	pass
