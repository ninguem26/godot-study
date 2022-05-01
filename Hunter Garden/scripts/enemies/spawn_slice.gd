extends Node2D

export(Array, Texture) var slice_list

var count: int = 0

func _ready() -> void:
	randomize()
	
	for slice in slice_list:
		var rigid: RigidBody2D = RigidBody2D.new()
		var sprite: Sprite = Sprite.new()
		var notifier: VisibilityNotifier2D = VisibilityNotifier2D.new()
		
		get_tree().root.call_deferred("add_child", rigid)
		
		rigid.add_child(sprite)
		rigid.add_child(notifier)
		
		var _connect = notifier.connect("screen_exited", self, "screen_exited", [rigid])
		
		sprite.texture = slice
		
		rigid.global_position = global_position
		rigid.apply_impulse(global_position, Vector2(rand_range(-30, 30), rand_range(-30, -120)))

func _process(_delta: float) -> void:
	if count == slice_list.size():
		queue_free()

func screen_exited(rigid_body: RigidBody2D) -> void:
	rigid_body.queue_free()
	count += 1
