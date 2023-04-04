extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite

var TW
var TW2

func _ready():
	TW = create_tween().set_loops()
	TW2 = create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	TW.tween_property(
		sprite, 'scale', Vector2(1.2, 1.2), .5
	).from_current().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	TW.tween_property(
		sprite, 'scale', Vector2(1, 1), .5
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	TW2.tween_property(sprite, 'position', Vector2(0, 2.5), 1)
	TW2.tween_property(sprite, 'position', Vector2(0, -1.5), 1)

func on_body_entered(body):
	TW.stop()
	TW2.stop()
	animation_player.play("collected")
