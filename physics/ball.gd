extends RigidBody2D

@export var speed: int = 100

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('mouse_left'):
		var mouse_pos = get_global_mouse_position()
		var impulse_direction = mouse_pos.direction_to(position)
		
		apply_impulse(impulse_direction * speed)
