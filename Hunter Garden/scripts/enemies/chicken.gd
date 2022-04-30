extends "res://scripts/enemies/enemy_template.gd"

export(int) var damage

func animate() -> void:
	if not on_hit:
		if abs(velocity.x) > 3:
			animation.play("Run")
		else:
			animation.play("Idle")
	else:
		set_physics_process(false)
		animation.play("Hit")

func update_health(amount: int) -> void:
	health -= amount
	on_hit = true
	
	if health <= 0:
		instance_explosion(Vector2(0, -20))
		queue_free()

func on_damage_body_entered(body: Object) -> void:
	body.update_health(damage, global_position)
