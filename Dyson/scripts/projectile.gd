extends Area2D

signal projectile_collision(damage)

export(float) var speed = 30.0

export(int) var damage = 1

func _physics_process(delta: float):
	var angle = Vector2(cos(rotation), sin(rotation))
	
	translate(speed*delta*angle)

func on_screen_exited():
	queue_free()

func on_body_entered(body: Node) -> void:
	var _connection = connect('projectile_collision', body, 'on_projectile_collision')
	
	emit_signal('projectile_collision', damage)
	queue_free()


func on_area_entered(_area: Area2D) -> void:
	queue_free()
