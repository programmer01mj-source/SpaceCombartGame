
extends Control

@onready var restart_button: Button = $VBoxContainer/RestartButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton

func _ready() -> void:
	if not restart_button.pressed.is_connected(_on_restart_pressed):
		restart_button.pressed.connect(_on_restart_pressed)

	if not main_menu_button.pressed.is_connected(_on_main_menu_pressed):
		main_menu_button.pressed.connect(_on_main_menu_pressed)

func _on_restart_pressed() -> void:
	print("Restart button pressed!")

	get_tree().paused = false

	var error = get_tree().change_scene_to_file(
        "res://space_level.tscn"
	)

	if error != OK:
		print("Could not restart level. Error: ", error)

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
