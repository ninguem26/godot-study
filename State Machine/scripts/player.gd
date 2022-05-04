extends KinematicBody2D

onready var state_machine: Object = $StateMachine

var velocity: Vector2
var acceleration: float = 0.9
var walk_speed: int = 150
var friction: float = 0.8

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
