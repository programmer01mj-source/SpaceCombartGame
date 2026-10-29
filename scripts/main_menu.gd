
extends Control

@onready var start_button: Button = $VBoxContainer/StartGameButton
@onready var select_ship_button: Button = $VBoxContainer/SelectShipButton
@onready var select_level_button: Button = $VBoxContainer/SelectLevelButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_game_pressed)
	select_ship_button.pressed.connect(_on_select_ship_pressed)
func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://space_level.tscn")
	
func _on_select_ship_pressed() -> void:
	get_tree().change_scene_to_file("res://ship_selection.tscn")
func _on_select_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_selection.tscn")
