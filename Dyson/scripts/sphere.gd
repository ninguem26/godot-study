extends StaticBody2D

signal update_health_bar(health)

export(NodePath) var star_path

export(float) var max_health = 500.0

onready var star: StaticBody2D = get_node(star_path)

var health: float

func _ready() -> void:
	global_position = star.global_position
	set_health(max_health)

func _draw() -> void:
	var center = Vector2.ZERO
	var radius = 80
	var angle_from = 0
	var angle_to = 360
	var color = Color(1.0, 0.0, 0.0)
	draw_circle_arc(center, radius, angle_from, angle_to, color)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func hit_by_projectile(damage: float) -> void:
	set_health(health - damage)

func set_health(new_health: float) -> void:
	health = new_health
	emit_signal('update_health_bar', health)
