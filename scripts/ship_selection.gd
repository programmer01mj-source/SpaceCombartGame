
extends Control

@onready var bob_button: Button = $VBoxContainer/BobButton
@onready var challenger_button: Button = $VBoxContainer/ChallengerButton
@onready var back_button: Button = $VBoxContainer/BackButton

func _ready() -> void:
	bob_button.pressed.connect(_on_bob_pressed)
	challenger_button.pressed.connect(_on_challenger_pressed)
	back_button.pressed.connect(_on_back_pressed)


func _on_bob_pressed() -> void:
	GameData.selected_ship = "Bob"
	print("Bob ship selected")

func _on_challenger_pressed() -> void:
	GameData.selected_ship = "Challenger"
	print("Challenger ship selected")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
