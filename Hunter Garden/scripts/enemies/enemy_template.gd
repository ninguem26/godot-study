extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")

export(bool) var on_hit = false
export(bool) var can_fly = false

export(int) var walk_speed
export(int) var gravity
export(int) var health

export(float) var acceleration
export(float) var friction

var player_ref: Object = null
var velocity: Vector2

func _physics_process(delta: float) -> void:
	move()
	animate()
	change_direction()

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func move() -> void:
	if player_ref != null and not can_fly:
		var direction: float = player_ref.global_position.x - global_position.x
		
		velocity.x = move_toward(velocity.x, walk_speed * direction, acceleration)
	elif not can_fly:
		velocity.x = move_toward(velocity.x, 0, friction)

func animate() -> void:
	pass

func change_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

func on_detection_body_entered(body: Object) -> void:
	player_ref = body

func on_detection_body_exited(_body: Object) -> void:
	player_ref = null

func on_damage_body_entered(_body: Object) -> void:
	pass
