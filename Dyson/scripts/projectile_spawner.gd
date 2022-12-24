extends Position2D

const PROJECTILE = preload('res://scenes/projectile.tscn')

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('attack'):
		spawn_projectile()

func spawn_projectile() -> void:
	var projectile: Object = PROJECTILE.instance()
	
	projectile.global_position = global_position
	projectile.rotation = get_global_transform().get_rotation()
	get_tree().root.call_deferred('add_child', projectile)
