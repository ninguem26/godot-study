extends KinematicBody2D

onready var state_machine: Object = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
