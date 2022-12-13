extends Area2D

export(float) var speed = 30.0
export(float) var damage = 1.0

func _physics_process(delta: float):
	var angle = Vector2(cos(rotation), sin(rotation))
	
	translate(speed*delta*angle)

func on_screen_exited():
	queue_free()

func on_body_entered(body: Node) -> void:
	body.hit_by_projectile(damage)
	queue_free()

func on_area_entered(_area: Area2D) -> void:
	queue_free()
