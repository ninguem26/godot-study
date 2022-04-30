extends "res://scripts/enemies/enemy_template.gd"

export(int) var damage
export(bool) var ceiling_out = false

var direction: Vector2

func move(delta: float) -> void:
	if player_ref != null:
		direction = (player_ref.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * walk_speed, acceleration * delta)
	else:
		direction = Vector2.ZERO
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func animate() -> void:
	if player_ref != null and not ceiling_out:
		animation.play("Ceiling_Out")
	elif not on_hit and player_ref != null and ceiling_out:
		animation.play("Flying")
	elif on_hit and ceiling_out:
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

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Ceiling_Out":
		animation.play("Flying")
