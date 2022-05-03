extends Area2D

const SLICE = preload("res://scenes/enemies/spawn_slice.tscn")

var direction: int

export(int) var speed
export(int) var damage
export(int) var health

func _physics_process(_delta: float) -> void:
	translate(Vector2(direction * speed, 0))

func _on_body_entered(body: Object) -> void:
	if body.is_in_group("Player"):
		body.update_health(damage, global_position)
	
	spawn_slice()

func spawn_slice() -> void:
	var slice: Object = SLICE.instance()
	
	get_tree().root.call_deferred("add_child", slice)
	slice.global_position = global_position
	queue_free()

func update_health(amount: int) -> void:
	health -= amount
	
	if health < 0:
		spawn_slice()

func _on_screen_exited() -> void:
	queue_free()
