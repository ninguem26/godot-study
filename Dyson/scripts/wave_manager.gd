extends Node

const ENEMY = preload("res://scenes/enemy.tscn")

export(int) var spawn_range = 500

onready var top_spawner_position: Position2D = get_node("TopSpawnerPosition")
onready var enemies: Node = get_node("Enemies")
onready var timer: Timer = get_node("Timer")

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var qnt_enemies_in_current_wave: int = 2

func _ready() -> void:
	rng.randomize()

func _process(_delta: float) -> void:
	if qnt_enemies() == 0 && timer.is_stopped():
		timer.start()

func add_enemy() -> void:
	var enemy: Object = ENEMY.instance()
	
	enemy.global_position = random_global_position()
	enemy.orbit_radius = rng.randi_range(300, 500)
	enemies.call_deferred('add_child', enemy)

func random_global_position() -> Vector2:
	var position = top_spawner_position.global_position
	position.x += rng.randi_range(-spawn_range, spawn_range)

	return position

func qnt_enemies() -> int:
	return enemies.get_children().size()

func next_wave() -> void:
	qnt_enemies_in_current_wave += 1
	
	for i in qnt_enemies_in_current_wave:
		add_enemy()

func on_timer_timeout() -> void:
	next_wave()
