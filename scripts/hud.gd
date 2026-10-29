
extends Control

@onready var health_label: Label = $Label

func update_health(current_health: int) -> void:
	health_label.text = "Health: " + str(current_health)
