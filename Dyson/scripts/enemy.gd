extends KinematicBody2D

onready var star_node: StaticBody2D = get_tree().root.get_child(0).get_node('Sun')

export(int) var health = 3
export(float) var speed = 260.0
export(float) var orbit_radius = 300.0

var pivot_point: Vector2
var orbit_position: Vector2

var current_angle: float

func _ready() -> void:
	pivot_point = star_node.global_position
	orbit_position = initial_position()
	current_angle = pivot_point.angle_to_point(orbit_position)

func _physics_process(delta: float) -> void:
	angular_move(1, orbit_radius, delta)

func initial_position() -> Vector2:
	var initial_vector: Vector2 = Vector2(global_position - pivot_point)
	var resized_vector: Vector2 = initial_vector.normalized()*orbit_radius
	
	return Vector2(resized_vector + pivot_point)

func angular_move(direction: int, radius: float, delta: float) -> void:
	var angular_speed: float = (speed/radius)*direction*delta

	current_angle -= angular_speed
	orbit_position = rotated_point(current_angle, radius)
	position = position.linear_interpolate(orbit_position, delta*0.8)
	look_at(pivot_point)

func rotated_point(angle, distance) -> Vector2:
	return pivot_point + Vector2(sin(angle), cos(angle)) * distance

func on_projectile_collision(damage: int) -> void:
	handle_damage(damage)

func handle_damage(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		queue_free()
