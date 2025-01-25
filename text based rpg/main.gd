extends Control

@onready var adventure_menu_button: Button = $Container/AdventureMenuButton
@onready var character_menu_button: Button = $Container/CharacterMenuButton

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_adventure_menu_button_up() -> void:
	get_tree().change_scene_to_file("res://adventure_menu.tscn")
