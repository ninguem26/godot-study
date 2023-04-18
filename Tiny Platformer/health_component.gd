class_name HealthComponent
extends Node

signal health_up_to_max(max_value: int)
signal health_down_to_zero
signal health_update(value: int)

@export var max_health: int = 3
@export var current_health: int = 3:
	set(value):
		if value >= max_health:
			current_health = max_health
			emit_signal('health_up_to_max', max_health)
		elif value <= 0:
			current_health = 0
			emit_signal('health_down_to_zero')
		else:
			current_health = value
			emit_signal('health_update', value)

func set_health_to_max() -> void:
	current_health = max_health
	emit_signal('health_up_to_max', max_health)

func set_health_to_zero() -> void:
	current_health = 0
	emit_signal('health_down_to_zero')

func set_health_to_value(value: int) -> void:
	current_health = value
	emit_signal('health_update', value)
