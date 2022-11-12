extends Node

const ENEMY = preload("res://scenes/enemy.tscn")

export(int) var spawn_range = 500

onready var top_spawner_position: Position2D = get_node("TopSpawnerPosition")
onready var enemies: Node = get_tree().root.get_child(0).get_node("Enemies")

var random = RandomNumberGenerator.new()

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if qnt_enemies() == 0:
		for i in 1:
			add_enemy()

func add_enemy() -> void:
	var enemy: Object = ENEMY.instance()
	
	enemy.global_position = random_global_position()
	enemies.call_deferred('add_child', enemy)

func random_global_position() -> Vector2:
	var position = top_spawner_position.global_position
	position.x += random.randi_range(-spawn_range, spawn_range)

	return position

func qnt_enemies() -> int:
	return enemies.get_children().size()
