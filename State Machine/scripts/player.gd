class_name Player
extends KinematicBody2D

onready var state_machine: Object = $StateMachine

export(int) var jump_counter = 1
export(float) var gravity = 0.9

var velocity: Vector2
var acceleration: float = 0.9
var friction: float = 0.8

var dir: int = 1
var current_jump_counter: int

# Called when the node enters the scene tree for the first time.
func _ready():
	current_jump_counter = jump_counter
	state_machine.init(self)

func _unhandled_input(event: InputEvent):
	state_machine.input(event)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)

func _process(delta: float) -> void:
	state_machine.process(delta)
