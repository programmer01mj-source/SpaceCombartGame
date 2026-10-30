extends Control

@onready var time_label: Label = $CenterContainer/VBoxContainer/TimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total_seconds: int = int(GameData.level_time)

	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60

	time_label.text = "Time Taken: %02d:%02d" % [minutes, seconds]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://planet_level.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
