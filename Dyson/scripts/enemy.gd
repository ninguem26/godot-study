extends KinematicBody2D

export(int) var health = 3

func on_projectile_collision(damage: int) -> void:
	handle_damage(damage)

func handle_damage(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		queue_free()
