extends Area2D

var direction: int = 1

export(int) var damage
export(int) var speed

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

func _ready() -> void:
	animated_sprite.play("Start")
	verify_direction()

func verify_direction() -> void:
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

func _physics_process(_delta: float) -> void:
	translate(Vector2(speed * direction, 0))


func on_body_entered(body) -> void:
	if body.is_in_group("Enemy"):
		body.update_health(damage)
	
	set_physics_process(false)
	animated_sprite.play("Hit")

func on_area_entered(area) -> void:
	if area.is_in_group("Projectile"):
		area.update_health(damage)
	
	set_physics_process(false)
	animated_sprite.play("Hit")


func on_animation_finished() -> void:
	match animated_sprite.animation:
		"Start":
			animated_sprite.play("Loop")
		"Hit":
			queue_free()


func on_screen_exited():
	queue_free()
